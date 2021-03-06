import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.35);

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 300) {
        siguientePagina();
      }
    });

    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: PageView.builder(
        itemCount: peliculas.length,
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-tarjeta';

    final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ));
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: tarjeta,
    );
  }

  // List<Widget> _tarjetas(context) {
  //   return peliculas.map((pelicula) {
  //     return Container(
  //         margin: EdgeInsets.only(right: 15.0),
  //         child: Column(
  //           children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(20.0),
  //               child: FadeInImage(
  //                 placeholder: AssetImage('assets/no-image.jpg'),
  //                 image: NetworkImage(pelicula.getPosterImg()),
  //                 fit: BoxFit.cover,
  //                 height: 120.0,
  //               ),
  //             ),
  //             SizedBox(
  //               height: 5.0,
  //             ),
  //             Text(
  //               pelicula.title,
  //               overflow: TextOverflow.ellipsis,
  //               style: Theme.of(context).textTheme.caption,
  //             ),
  //           ],
  //         ));
  //   }).toList();
  // }
}
