import java.util.*;
OpenSimplexNoise noise;
boolean openSimplex=true;
float noiseScale=0.02;
float rad=random(.75,2);
int numFrames=75;
List<Line> lines=new ArrayList<Line>();
float[] getOpenNoiseValues(float x,float y,int numVals,float soFarStep,float indexStep){
  return getOpenNoiseValues(x,y,noiseScale,rad,noise,frameCount,numFrames,numVals,soFarStep,indexStep);
}
float[] getOpenNoiseValues(float x,float y,float s,float r,OpenSimplexNoise n,float soFar,float max,int numVals,float soFarStep,float indexStep){
  float[] vals=new float[numVals];
  for(int i=0;i<vals.length;i++){
    float t=1.0*(soFar-soFarStep*(i+indexStep))/max;
    t=t*2*(float)Math.PI;
    vals[i]=(float)n.eval(s*x,s*y,r*cos(t),r*sin(t));
  }
  return vals;
}
float[] getNoiseValues(float x,int n){
  return getNoiseValues(x,n,10,0);
}
float[] getNoiseValues(float x,int numVals,float soFarStep,float indexStep){
  return getNoiseValues(x,noiseScale,rad,frameCount,numFrames,numVals,soFarStep,indexStep);
}
float[] getNoiseValues(float x,float s,float r,float soFar,float max,int numVals,float soFarStep,float indexStep){
  float[] vals=new float[numVals];
  for(int i=0;i<vals.length;i++){
    float t=1.0*(soFar-soFarStep*(i+indexStep))/max;
    t=t*2*(float)Math.PI;
    vals[i]=noise(s*x,r*cos(t),r*sin(t));
  }
  return vals;
}
void setup(){
  size(600,600);
  background(0);
  stroke(255);
  strokeWeight(5);
  if(openSimplex)
    noise=new OpenSimplexNoise();
  for(int i=0;i<20;i++)
    lines.add(new Line());
}
void draw(){
  fill(0,0,0,16);
  noStroke();
  rect(0,0,width,height);
  for(int i=0;i<lines.size();i++)
    lines.get(i).move(10,i);
  if(frameCount==numFrames*2)
    stop();
  if(frameCount>=numFrames&&frameCount<numFrames*2)
    saveFrame("Frames/###.png");
}