import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nominatim_flutter/model/response/nominatim_response.dart';
import 'package:travel_app/services/nominatim_service.dart';
import 'package:travel_app/utils/address_formatter.dart';

class LocationSearchBar extends StatefulWidget {
  final Function(LatLng) onPlaceSelected;

  const LocationSearchBar({super.key, required this.onPlaceSelected});

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final _controller = TextEditingController();
  List<NominatimResponse> _results = [];
  bool _loading = false;
  Timer? _debounce;

  void _onChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (_controller.text.isNotEmpty) {
        _search();
      } else {
        if (mounted) setState(() => _results.clear());
      }
    });
  }

  Future<void> _search() async {
    if (!mounted) return;
    setState(() => _loading = true);
    try {
      final r = await NominatimService.searchPlaces(_controller.text);
      if (!mounted) return;
      setState(() {
        _results = r;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _results = [];
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Material(
              color: Color.fromRGBO(255, 255, 255, 0.9),
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Pesquisar',
                        border: InputBorder.none,
                      ),
                      onChanged: (_) => _onChanged(),
                    ),
                  ),
                  if (_loading)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 16, height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                ],
              ),
            ),
            if (_results.isNotEmpty)
              Material(
                color: Colors.white,
                elevation: 4,
                borderRadius: BorderRadius.circular(16),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _results.length,
                  itemBuilder: (_, i) {
                    final res = _results[i];
                    return ListTile(
                      title: Text(formatStopAddress(res.address!)),
                      onTap: () {
                        final lat = double.tryParse(res.lat ?? '0') ?? 0;
                        final lon = double.tryParse(res.lon ?? '0') ?? 0;
                        widget.onPlaceSelected(LatLng(lat, lon));
                        if (mounted) setState(() => _results.clear());
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
