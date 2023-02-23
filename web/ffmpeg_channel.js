const { createFFmpeg } = FFmpeg;

async function convert() {
    const ffmpeg = createFFmpeg({ log: true });
    await ffmpeg.load();
}

convert()