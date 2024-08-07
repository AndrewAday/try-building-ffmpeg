./download_ffmpeg.bash
./configure_ffmpeg.bash arm64
cd ffmpeg && make -j
mv VERSION _VERSION_  # avoids include naming conflict
cd ..
cmake -B build
cmake --build build
mkdir -p ./output
./build/tryffmpeg sample_640x360.mpeg ./output/frame
