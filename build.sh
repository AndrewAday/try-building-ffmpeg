./configure_ffmpeg.bash arm64
cd ffmpeg && make -j
cd ..
cmake -B build
cmake --build build
mkdir -p ./output
./build/tryffmpeg sample_640x360.mpeg ./output/frame
