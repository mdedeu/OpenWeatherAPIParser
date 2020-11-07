#!/bin/bash
lat=${1#*=}
lon=${2#*=}
cnt=${3#*=}
curl "https://api.openweathermap.org/data/2.5/find?lat=${lat}&lon=${lon}&cnt=${cnt}&mode=xml&appid=91ce8f66d5b64f3f77d8289444e5aeb5" -o data.xml 
echo "----------------------------------------"
echo "Data.xml generated from OpenWeatherAPI"
echo "----------------------------------------"
java net.sf.saxon.Query -q:extract_weather_data.xq lat=$lat long=$lon cnt=$cnt > "weather_data.xml"
echo "We are halfway through it! Keep Going. Generated auxiliar file 'weather_data.xml'. "
echo "----------------------------------------"
java net.sf.saxon.Transform -s:./weather_data.xml -xsl:./generate_page.xsl -o:weather_page.html
echo "Page generated, check your directory. Please check the READ.me for further instructions" #(esto es para que linkee el css con el html, o se lo linkeamos de prepo?)
echo "----------------------------------------"
echo "If 'weather_page.html' is empty, check the error output in 'weather_data.xml'."