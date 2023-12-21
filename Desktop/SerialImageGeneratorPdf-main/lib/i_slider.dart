import 'package:flutter/material.dart';

class ISlider extends StatelessWidget {
  const ISlider(
      {super.key,
      required this.title,
       this.output,
      this.min = 0,
      this.max = 100,
      required this.value,this.direction=DirectionSlider.oneDirection,
      required this.onChanged, this.onEndChanged});
  final String? title, output;
  final double min, max, value;
  final DirectionSlider direction;
  final Function(double? value,) onChanged;
  final Function(double? value)? onEndChanged;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min,
      children: [
        
      Text(title!),  Expanded(
        child: SizedBox(height: 34,
            child: Stack(
              children: [ Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                     if(direction==DirectionSlider.twoDirections)   Expanded(
                          flex:1,
                          child: LinearProgressIndicator(
                            value:1-value/min,
                            color: Colors.grey,
                         backgroundColor:Colors.blue ,
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child: LinearProgressIndicator(
                            value: value/max,
                            color: Colors.blue ,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                SliderTheme(data:  const SliderThemeData(trackHeight: 5,thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7)),
                  child: Slider(activeColor: Colors.transparent,inactiveColor: Colors.transparent,
                   thumbColor: Colors.blue ,
                    max: max, min: min, value: value>=max?max:value, onChanged: (value){
                      onChanged(value);
                    },onChangeStart: (value) {
                     
                
                      onChanged(value,);
                    
                    },),
                ),
              ],
            ),
          ),
      ),Container(
                  child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child:  Text(value>=max?"Max": output??value.toStringAsFixed(1))),
              )
      ],
    );
  }
}
enum DirectionSlider{
  oneDirection,
  twoDirections,
}