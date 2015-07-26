class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(String imagePrefix, int count, int across, int up){
    imageCount = count;
    images = new PImage[imageCount];
    
    for (int i = 0; i < imageCount; i++){
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 4) + ".png";
      PImage img = loadImage(filename);
      img.resize(across, up);
      images[i] = img;
    }
  }
  
  void show(float xpos, float ypos){
    frame = (frame+1) % (10 * imageCount);
    image(images[frame / 10], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
}
