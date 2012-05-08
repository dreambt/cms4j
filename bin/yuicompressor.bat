@echo off
echo Please download the yuicompressor from http://yuilibrary.com/downloads/yuicompressor and put the jar file here.

echo ### Old ###
echo Compressing.... static\css\ie6.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\ie6.min.css ..\src\main\webapp\static\css\ie6.css
echo Compressing.... static\css\inner.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\inner.min.css ..\src\main\webapp\static\css\inner.css
echo Compressing.... static\css\style.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\style.min.css ..\src\main\webapp\static\css\style.css
echo Compressing.... static\css\superfish.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\superfish.min.css ..\src\main\webapp\static\css\superfish.css
echo Compressing.... static\css\ui.totop.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\ui.totop.min.css ..\src\main\webapp\static\css\ui.totop.css

echo ### Blueprint ###
echo Compressing.... static\blueprint\1.0.1\ie.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\blueprint\1.0.1\ie.min.css ..\src\main\webapp\static\blueprint\1.0.1\ie.css
echo Compressing.... static\blueprint\1.0.1\print.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\blueprint\1.0.1\print.min.css ..\src\main\webapp\static\blueprint\1.0.1\print.css
echo Compressing.... static\blueprint\1.0.1\screen.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\blueprint\1.0.1\screen.min.css ..\src\main\webapp\static\blueprint\1.0.1\screen.css
echo Compressing.... static\blueprint\1.0.1\screen-customized.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\blueprint\1.0.1\screen-customized.min.css ..\src\main\webapp\static\blueprint\1.0.1\screen-customized.css

echo ### jquery-validation ###
echo Compressing.... static\jquery-validation/1.9.0/validate.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\jquery-validation/1.9.0/validate.min.css ..\src\main\webapp\static\jquery-validation/1.9.0/validate.css

echo ### 404 ###
echo Compressing.... static\404\colors.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\404\colors.min.css ..\src\main\webapp\static\404\colors.css
echo Compressing.... static\404\screen.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\404\screen.min.css ..\src\main\webapp\static\404\screen.css

echo ### CMS ###
echo Compressing.... static\CMS.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\CMS.min.css ..\src\main\webapp\static\CMS.css


pause