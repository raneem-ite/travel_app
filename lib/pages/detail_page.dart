import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/app_cubit.dart';
import 'package:flutter_cubit/cubit/app_cubit_state.dart';
import 'package:flutter_cubit/misc/colors.dart';
import 'package:flutter_cubit/model/data_model.dart';
import 'package:flutter_cubit/widgets/app_button.dart';
import 'package:flutter_cubit/widgets/app_large_text.dart';
import 'package:flutter_cubit/widgets/app_text.dart';
import 'package:flutter_cubit/widgets/responsive_button.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitState>(
        builder: (context, state) {
          if (state is DetailState) {
            DataModel place = state.place;
            return SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Stack(
                  children: [
                    // background image
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'http://mark.bslmeiyu.com/uploads/' +
                                    place.img),
                          ),
                        ),
                      ),
                    ),
                    //menu button
                    Positioned(
                      left: 20,
                      top: 70,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              BlocProvider.of<AppCubits>(context).goHome();
                            },
                          ),
                        ],
                      ),
                    ),

                    //card details
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.35,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.65,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: cardFullDetails(place),
                      ),
                    ),

                    Positioned(
                        bottom: 40,
                        left: 20,
                        right: 20,
                        child: Row(
                          children: const [
                            AppButton(
                                color: AppColors.textColor1,
                                backgroundColor: Colors.white,
                                size: 60,
                                borderColor: AppColors.textColor1,
                                isIcon: true,
                                icon: Icons.favorite_border_outlined),
                            // Spacer(),
                            SizedBox(
                              width: 20,
                            ),
                            ResponsiveButton(
                              isResponsive: true,
                            ),
                          ],
                        ))
                  ],
                ));
          } else {
            return Text("no data");
          }
        },
      ),
    );
  }

  Widget cardFullDetails(DataModel place) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          // top
          children: [
            Row(
              children: [
                AppLargeText(
                  text: place.name,
                  color: Colors.black54,
                ),
                Spacer(),
                AppLargeText(
                  text: "${place.price.toString()}\$",
                  color: AppColors.mainColor,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //location
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.mainColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                AppText(text: place.location, color: AppColors.textColor1)
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            //ranking
            Row(
              children: [
                Wrap(
                  children: List.generate(
                      5,
                      (indexinList) => Icon(
                            Icons.star,
                            color: indexinList < place.stars
                                ? AppColors.starColor
                                : AppColors.textColor2,
                          )),
                ),
                const SizedBox(
                  width: 5,
                ),
                AppText(
                  text: "(${place.stars}.0)",
                  color: AppColors.textColor2,
                )
              ],
            ),

            const SizedBox(
              height: 40,
            ),
            AppLargeText(
              text: "People",
              size: 20,
              color: Colors.black.withOpacity(0.8),
            ),
            const SizedBox(
              height: 5,
            ),
            const AppText(
              text: "Number of people in your group",
              color: AppColors.mainTextColor,
            ),
            const SizedBox(
              height: 15,
            ),

            //people numbers
            Wrap(
              children: List.generate(
                  place.people,
                  (index) => InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: AppButton(
                            backgroundColor: _selectedIndex == index
                                ? Colors.black
                                : AppColors.buttonBackground,
                            borderColor: AppColors.buttonBackground,
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.black,
                            size: 50,
                            text: (index + 1).toString(),
                          ),
                        ),
                      )),
            ),

            const SizedBox(height: 35),
            AppLargeText(
              text: "Description",
              color: Colors.black.withOpacity(0.8),
              size: 20,
            ),
            const SizedBox(height: 10),
            AppText(
              text:
                  // "Yosemite National Park is located in central  Sierra Nevada in US state of Califonia. It is located near the wild Protected areas",
                  place.desc,
              color: AppColors.textColor2,
            ),
          ]),
    );
  }
}
