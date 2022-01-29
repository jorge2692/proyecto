import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';


class Cards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'ciudad'),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical:10 ),
          child: Text('Ciudades', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          Container(
            width: double.infinity,
            height: size.height * 0.4,
            child: Swiper(
                outer:false,
                itemBuilder: (c, i) {
                  return Wrap(
                    runSpacing: 6.0,
                    children: [1,2,3,4,5,6].map((i){
                      return SizedBox(
                        width: MediaQuery.of(context).size.width/3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: FadeInImage(
                                  placeholder:  AssetImage('assets/no-image.jpg'),
                                  image: NetworkImage('https://via.placeholder.com/400x500'),
                                ),
                              ),
                              height: MediaQuery.of(context).size.width * 0.29,
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                            Padding(padding: EdgeInsets.only(top:1.0),child: Text('hello a ver si pasa lo mismo cuando escribo cosas muy largas en este ejemplo',maxLines: 2,overflow: TextOverflow.ellipsis),)
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
                pagination: SwiperPagination(
                    margin: EdgeInsets.all(6.0)
                ),
                itemCount: 3,
              ),
        ),
      ],
      ),
    );
  }
}
