mkdir final
cd final
echo "password" | sudo -S apt-get install git build-essential flex bison llvm clang
git clone https://github.com/gjlmotea/Compiler-sample
cd ..
cp makefile ./final/Compiler-sample
cd final/Compiler-sample
make all
