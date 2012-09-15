@echo off
echo Please download the yuicompressor from http://yuilibrary.com/downloads/yuicompressor and put the jar file here.

echo ### CSS ###
echo Compressing.... static\style\main.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\style\main.min.css ..\src\main\webapp\static\style\main.css
echo Compressing.... static\style\admin.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\style\admin.min.css ..\src\main\webapp\static\style\admin.css

echo Compressing.... static\js\main.js
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\js\main.min.js ..\src\main\webapp\static\js\main.js

echo Compressing.... static\js\validation\validate.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\js\validation\validate.min.css ..\src\main\webapp\static\js\validation\validate.css

echo Compressing.... static\404\colors.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\404\colors.min.css ..\src\main\webapp\static\404\colors.css
echo Compressing.... static\404\screen.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\404\screen.min.css ..\src\main\webapp\static\404\screen.css


echo Compressing.... static\js\markitup\style.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\js\markitup\style.min.css ..\src\main\webapp\static\js\markitup\style.css


pause