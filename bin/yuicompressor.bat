@echo off
echo Please download the yuicompressor from http://yuilibrary.com/downloads/yuicompressor and put the jar file here.

echo Compressing.... static\css\ie6.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\ie6.min.css ..\src\main\webapp\static\css\ie6.css
echo Compressing.... static\css\inner.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\inner.min.css ..\src\main\webapp\static\css\inner.css
echo Compressing.... static\css\style.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\style.min.css ..\src\main\webapp\static\css\style.css
echo Compressing.... static\css\superfish.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\css\superfish.min.css ..\src\main\webapp\static\css\superfish.css

echo Compressing.... static\CMS.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\CMS.min.css ..\src\main\webapp\static\CMS.css

echo Compressing.... static\jquery-validation/1.9.0/validate.css
java -jar yuicompressor-2.4.7.jar -o ..\src\main\webapp\static\jquery-validation/1.9.0/validate.min.css ..\src\main\webapp\static\jquery-validation/1.9.0/validate.css

pause