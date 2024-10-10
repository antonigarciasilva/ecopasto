import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';

//Para iniciar un código de cero STLES
class LocationPage extends StatelessWidget {
  final StateBiomass stateBiomass;
  const LocationPage({super.key, required this.stateBiomass});

  //final StateBiomass stateBiomass = StateBiomass();

  //Método para abrir Google Maps con latitud y longitud
  Future<void> _openGoogleMaps(double latitude, double longitude) async {
    final Uri googlemapsurl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (await launchUrl(googlemapsurl)) {
      await launchUrl(googlemapsurl);
    } else {
      throw 'No se pudo abrir Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.white)),
        onPressed: () async {
          //obtener la ubicación
          await stateBiomass.getCurrentLocation();

          //Verificamos si la latiutud y longitud fueron obtenidas correctamente
          if (stateBiomass.latitude != null && stateBiomass.longitude != null) {
            //Mostrar Google Maps con la ubicación
            await _openGoogleMaps(
                stateBiomass.latitude!, stateBiomass.longitude!);
          } else {
            //Mostrar mensaje de error si no se obtuvieron las coordenadas
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('No se puede obtener la ubicación'),
            ));
          }
        },
        child: const Text(
          'Obtener mi ubicación',
          style: TextStyle(color: Colors.blue),
        ));
  }
}
