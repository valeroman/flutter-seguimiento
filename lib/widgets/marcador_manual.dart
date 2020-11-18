part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {

        if (state.seleccionManual) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
      }
      
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [

        // Botón regresar
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(microseconds: 250),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black87,),
                onPressed: () {
                  BlocProvider.of<BusquedaBloc>(context).add(OnDesactivarMarcadorManual());
                },
              ),
            ),
          ),
        ),

        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: BounceInDown(
              from: 200,
              child: Icon(
                Icons.location_on, 
                size: 50
              ),
            )
          ),
        ),

        // Botón de confirmar destino
        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: width -120,
              child: Text('Confirmar destino', style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {

                calcularDestino(context);
              },
            ),
          ),
        )
      ],
    );
  }

  void calcularDestino(BuildContext context) async {

    calculandoAlerta(context);

    final trafficService = new TrafficService();
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
    final destino = mapaBloc.state.ubicacionCentral;
    

    // Obtener informacion del destino


    final reverseQueryResponse = await trafficService.getCoordenadasInfo(destino);

    final trafficResponse = await trafficService.getCoordsInicioYDestino(inicio, destino);

    final geometry = trafficResponse.routes[0].geometry;
    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;
    final nombreDestino = reverseQueryResponse.features[0].text;
    final descripcionDestino = reverseQueryResponse.features[0].placeNameEs;


    // Decodificar los puntos del geometry
    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords;
    final List<LatLng> rutaCoordenadas = points.map(
      (point) => LatLng(point[0], point[1])
      ).toList();

    mapaBloc.add(OnCrearRutaInicioDestino(rutaCoordenadas, distancia, duracion, nombreDestino));

    Navigator.of(context).pop();
    BlocProvider.of<BusquedaBloc>(context).add(OnDesactivarMarcadorManual());

    print('Destino==> $nombreDestino');
    print('Destino_lat==> $destino');

    // Agregar al Historial

    final busquedaBloc = BlocProvider.of<BusquedaBloc>(context);
    busquedaBloc.add(OnAgregarHistorial(
      SearchResult(
        cancelo: false,
        manual: false,
        position: LatLng(destino.longitude, destino.latitude ),
        nombreDestino: nombreDestino,
        descripcion: descripcionDestino
      )
    ));

  }
}