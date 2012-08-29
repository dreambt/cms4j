@echo off
echo Please download the yuicompressor from http://yuilibrary.com/downloads/yuicompressor and put the jar file here.

echo ### CSS ###
echo Compressing.... static\css\style.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\style.min.css ..\src\main\webapp\static\css\style.css
echo Compressing.... static\css\admin.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\admin.min.css ..\src\main\webapp\static\css\admin.css
echo Compressing.... static\css\ui.totop.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\ui.totop.min.css ..\src\main\webapp\static\css\ui.totop.css

echo Compressing.... static\js\jquery-validation\validate.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\js\jquery-validation\validate.min.css ..\src\main\webapp\static\js\jquery-validation\validate.css

echo Compressing.... static\404\colors.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\404\colors.min.css ..\src\main\webapp\static\404\colors.css
echo Compressing.... static\404\screen.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\404\screen.min.css ..\src\main\webapp\static\404\screen.css

echo ### bootstrap datepicker ###
echo Compressing.... static\bootstrap\css\datepicker.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\bootstrap\css\datepicker.min.css ..\src\main\webapp\static\bootstrap\css\datepicker.css
echo Compressing.... static\bootstrap\js\bootstrap-datepicker.js
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\bootstrap\js\bootstrap-datepicker.min.js ..\src\main\webapp\static\bootstrap\js\bootstrap-datepicker.js

echo Compressing.... static\js\markitup\style.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\js\markitup\style.min.css ..\src\main\webapp\static\js\markitup\style.css


echo ### js ###
echo Compressing.... static\js\slider.js
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\js\slider.js ..\src\main\webapp\static\js\slider.js

pause