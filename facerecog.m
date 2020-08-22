faces = imageSet('database','recursive');
img = imread('C:\trial.jpg');                      
facedetector = vision.CascadeObjectDetector;   
bboxes = step(facedetector, img);                
inpu = imcrop(img,bboxes);           
gray = rgb2gray(inpu);
input = imresize(gray,[150 150]);
point = detectSURFFeatures(input);                                               
[infeat, vp]= extractFeatures(input,point);   
features = bagOfFeatures(faces);
for i= 1:2
    obj = trainImageCategoryClassifier(faces,features);    
end
acc = evaluate(obj,faces);
accuracy = mean(diag(acc));
[label1, scores] = predict(obj,input);
if accuracy > 0.2
output = obj.Labels(label1);
msgbox(obj.Labels(label1))
else 
    disp('Not Found')
end