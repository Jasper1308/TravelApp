import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/l10n/app_localizations.dart';
import 'package:travel_app/presentation/providers/travel_details_provider.dart';
import 'package:travel_app/presentation/widgets/travel_map_widget.dart';
import 'package:travel_app/presentation/widgets/travel_stop_card.dart';
import 'package:travel_app/presentation/widgets/participant_list.dart';
import 'package:travel_app/presentation/providers/pdf_generator_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TravelDetailsScreen extends StatefulWidget {
  final int travelId;

  const TravelDetailsScreen({super.key, required this.travelId});

  @override
  State<TravelDetailsScreen> createState() => _TravelDetailsScreenState();
}

class _TravelDetailsScreenState extends State<TravelDetailsScreen> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TravelDetailsProvider>().load(widget.travelId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailsProvider = context.watch<TravelDetailsProvider>();
    final pdfProvider = context.watch<PdfGeneratorProvider>();
    final travelDetails = detailsProvider.details;
    final l10n = AppLocalizations.of(context)!;

    if (detailsProvider.loading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
      );
    }

    if (travelDetails == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.travelDetails),
        ),
        body: Center(child: Text(l10n.errorLoadingDetails)),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text(
                travelDetails.travel.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
              background: Hero(
                tag: 'travel-${travelDetails.travel.travelId}',
                child: Container(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.participants,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  ParticipantsListWidget(participants: travelDetails.participants),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.myStops,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TravelMapWidget(
                    stops: travelDetails.stops,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                  ),
                  const SizedBox(height: 24),
                  if (travelDetails.stops.isEmpty)
                    Center(
                      child: Text(l10n.noStopsRegistered),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: travelDetails.stops.length,
                      itemBuilder: (context, i) {
                        final stop = travelDetails.stops[i];
                        return TravelStopCard(
                          stop: stop,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/stop-details',
                              arguments: stop.travelStopId,
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton.icon(
            onPressed: pdfProvider.loading || _mapController == null
                ? null
                : () async {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.loadingPdf)),
              );
              await pdfProvider.generate(
                context,
                travelDetails,
                _mapController!,
              );
            },
            icon: const Icon(Icons.picture_as_pdf),
            label: Text(l10n.generatePdf),
          ),
        ),
      ),
    );
  }
}