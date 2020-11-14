import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapa_app/bloc/mapa/mapa_bloc.dart';
import 'package:mapa_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapa_app/widgets/widgets.dart';


class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Saber cual es la ultima ubicacion conocida del usuario
    // se puede validar si existeUbicacion
    // BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;

    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (_, state) => crearMapa(state)
          ),

          Positioned(
            top: 15,
            child: SearchBar()
          ),

          MarcadorManual(),

        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          BtnUbicacion(),

          BtnSeguirUbicacion(),

          BtnMiRuta(),

          
        ],
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    //Se podria guardar los datos de long y lat en bd
    
    if (!state.existeUbicacion) return Center(child: Text('Ubicando...'));

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    mapaBloc.add(OnNuevaUbicacion(state.ubicacion));

    //return Text('${ state.ubicacion.latitude }, ${ state.ubicacion.longitude }');
    final cameraPosition = new CameraPosition(
      target: state.ubicacion,
      zoom: 15
    );

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, _) {
        
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated:  mapaBloc.initMapa,
          polylines: mapaBloc.state.polylines.values.toSet(),
          onCameraMove: (cameraPosition) {
            // cameraPosition.target = LatLng central del mapa
            mapaBloc.add(OnMovioMapa(cameraPosition.target));
          },
        );
      },
    );
  }
}