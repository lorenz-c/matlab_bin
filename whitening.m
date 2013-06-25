function [Fw, B] = whitening(F, eofs, lams);


scales = sqrt(lams);
B      = diag(1./scales)*eofs;

Fw     = eofs*F;

