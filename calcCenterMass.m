function center= calcCenterMass(dataLine)

[rows cols]= size(dataLine);

for i=1:rows
    data= dataLine(i,:); 
    [A(1,i) A(2,i)]= CenterOfMass(data);
    center(1,i) = A(1,i);
    center(2,i) = i-1; 
end
  

return
