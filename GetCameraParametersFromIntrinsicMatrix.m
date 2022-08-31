function [fc,cc,alphac] = GetCameraParametersFromIntrinsicMatrix(KK)

fc = [KK(1,1) KK(2,2)]';
cc = [KK(1,3) KK(2,3)]';
alphac = KK(1,2);

end