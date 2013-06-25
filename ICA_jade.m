function B = ICA_jade(X, B)
verbose	= 1
[m, T] = size(X);


%% Reshaping of the data, hoping to speed up things a little bit...
X = X';

dimsymm = (m*(m+1))/2;	    % Dim. of the space of real symm matrices
nbcm 	= dimsymm  ; 	    % number of cumulant matrices
CM 		= zeros(m,m*nbcm);  % Storage for cumulant matrices
R 		= eye(m);  	        %% 
Qij 	= zeros(m);       	% Temp for a cum. matrix
Xim		= zeros(m,1);	    % Temp
Xijm	= zeros(m,1);	    % Temp
Uns		= ones(1,m);        % for convenience


%% I am using a symmetry trick to save storage.  I should write a short note one of these
%% days explaining what is going on here.
%%
Range     = 1:m ; % will index the columns of CM where to store the cum. mats.

for im = 1:m
  Xim = X(:,im) ;
  Xijm= Xim.*Xim ;
  %% Note to myself: the -R on next line can be removed: it does not affect
  %% the joint diagonalization criterion
  Qij           = ((Xijm(:,Uns).*X)' * X)/T - R - 2 * R(:,im)*R(:,im)' ;
  CM(:,Range)	= Qij ; 
  Range         = Range  + m ; 
  for jm = 1:im-1
    Xijm        = Xim.*X(:,jm) ;
    Qij         = sqrt(2) *(((Xijm(:,Uns).*X)' * X)/T - R(:,im)*R(:,jm)' - R(:,jm)*R(:,im)') ;
    CM(:,Range)	= Qij ;  
    Range       = Range  + m ;
  end ;
end;
%%%% Now we have nbcm = m(m+1)/2 cumulants matrices stored in a big m x m*nbcm array.



%%% joint diagonalization of the cumulant matrices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Init
if 0, 	%% Init by diagonalizing a *single* cumulant matrix.  It seems to save
	%% some computation time `sometimes'.  Not clear if initialization is really worth
	%% it since Jacobi rotations are very efficient.  On the other hand, it does not
	%% cost much...

    fprintf('jade -> Initialization of the diagonalization\n');
	[V,D]	= eig(CM(:,1:m)); % Selectng a particular cumulant matrix.
	for u=1:m:m*nbcm,         % Accordingly updating the cumulant set given the init
		CM(:,u:u+m-1) = CM(:,u:u+m-1)*V ; 
	end;
	CM	= V'*CM;

else,	%% The dont-try-to-be-smart init
	V	= eye(m) ; % la rotation initiale
end;

%% Computing the initial value of the contrast 
Diag    = zeros(m,1) ;
On      = 0 ;
Range   = 1:m ;
for im = 1:nbcm,
  Diag  = diag(CM(:,Range)) ;
  On    = On + sum(Diag.*Diag) ;
  Range = Range + m ;
end
Off = sum(sum(CM.*CM)) - On ;



seuil	= 1.0e-6 / sqrt(T) ; % A statistically scaled threshold on `small' angles
encore	= 1;
sweep	= 0; % sweep number
updates = 0; % Total number of rotations
upds    = 0; % Number of rotations in a given seep
g	= zeros(2,nbcm);
gg	= zeros(2,2);
G	= zeros(2,2);
c	= 0 ;
s 	= 0 ;
ton	= 0 ;
toff	= 0 ;
theta	= 0 ;
Gain    = 0 ;

%% Joint diagonalization proper
if verbose, fprintf('jade -> Contrast optimization by joint diagonalization\n'); end

while encore, encore=0;   

  if verbose, fprintf('jade -> Sweep #%3d',sweep); end
  sweep = sweep+1;
  upds  = 0 ; 
  Vkeep = V ;
  
  for p=1:m-1,
    for q=p+1:m,

      Ip = p:m:m*nbcm ;
      Iq = q:m:m*nbcm ;
      
      %%% computation of Givens angle
      g	    = [ CM(p,Ip)-CM(q,Iq) ; CM(p,Iq)+CM(q,Ip) ];
      gg    = g*g';
      ton   = gg(1,1)-gg(2,2); 
      toff  = gg(1,2)+gg(2,1);
      theta = 0.5*atan2( toff , ton+sqrt(ton*ton+toff*toff) );
      Gain  = (sqrt(ton*ton+toff*toff) - ton) / 4 ;
      
      %%% Givens update
      if abs(theta) > seuil,
%%      if Gain > 1.0e-3*On/m/m ,
	encore  = 1 ;
	upds    = upds    + 1;
	c	= cos(theta); 
	s	= sin(theta);
	G	= [ c -s ; s c ] ;
	
	pair 		= [p;q] ;
	V(:,pair) 	= V(:,pair)*G ;
	CM(pair,:)	= G' * CM(pair,:) ;
	CM(:,[Ip Iq]) 	= [ c*CM(:,Ip)+s*CM(:,Iq) -s*CM(:,Ip)+c*CM(:,Iq) ] ;
	

	On   = On  + Gain;
	Off  = Off - Gain;
	
	%% fprintf('jade -> %3d %3d %12.8f\n',p,q,Off/On);
      end%%of the if
    end%%of the loop on q
  end%%of the loop on p
  if verbose, fprintf(' completed in %d rotations\n',upds); end
  updates = updates + upds ;
  
end%%of the while loop
if verbose, fprintf('jade -> Total of %d Givens rotations\n',updates); end


%%% A separating matrix
%   ===================
B	= V'*B ;


%%% Permut the rows of the separating matrix B to get the most energetic components first.
%%% Here the **signals** are normalized to unit variance.  Therefore, the sort is
%%% according to the norm of the columns of A = pinv(B)

if verbose, fprintf('jade -> Sorting the components\n',updates); end
A           = pinv(B) ;
[Ds,keys]   = sort(sum(A.*A)) ;
B           = B(keys,:)       ;
B           = B(m:-1:1,:)     ; % Is this smart ?


% Signs are fixed by forcing the first column of B to have non-negative entries.

if verbose, fprintf('jade -> Fixing the signs\n',updates); end
b	= B(:,1) ;
signs	= sign(sign(b)+0.1) ; % just a trick to deal with sign=0
B	= diag(signs)*B ;



return ;


% To do.
%   - Implement a cheaper/simpler whitening (is it worth it?)
% 
% Revision history:
%
%- V1.8, May 2005
%  - Added some commented code to explain the cumulant computation tricks.
%  - Added reference to the Neural Comp. paper.
%
%-  V1.7, Nov. 16, 2002
%   - Reverted the mean removal code to an earlier version (not using 
%     repmat) to keep the code octave-compatible.  Now less efficient,
%     but does not make any significant difference wrt the total 
%     computing cost.
%   - Remove some cruft (some debugging figures were created.  What 
%     was this stuff doing there???)
%
%
%-  V1.6, Feb. 24, 1997 
%   - Mean removal is better implemented.
%   - Transposing X before computing the cumulants: small speed-up
%   - Still more comments to emphasize the relationship to PCA
%
%-  V1.5, Dec. 24 1997 
%   - The sign of each row of B is determined by letting the first element be positive.
%
%-  V1.4, Dec. 23 1997 
%   - Minor clean up.
%   - Added a verbose switch
%   - Added the sorting of the rows of B in order to fix in some reasonable way the
%     permutation indetermination.  See note 2) below.
%
%-  V1.3, Nov.  2 1997 
%   - Some clean up.  Released in the public domain.
%
%-  V1.2, Oct.  5 1997 
%   - Changed random picking of the cumulant matrix used for initialization to a
%     deterministic choice.  This is not because of a better rationale but to make the
%     ouput (almost surely) deterministic.
%   - Rewrote the joint diag. to take more advantage of Matlab's tricks.
%   - Created more dummy variables to combat Matlab's loose memory management.
%
%-  V1.1, Oct. 29 1997.
%    Made the estimation of the cumulant matrices more regular. This also corrects a
%    buglet...
%
%-  V1.0, Sept. 9 1997. Created.
%
% Main references:
% @article{CS-iee-94,
%  title 	= "Blind beamforming for non {G}aussian signals",
%  author       = "Jean-Fran\c{c}ois Cardoso and Antoine Souloumiac",
%  HTML 	= "ftp://sig.enst.fr/pub/jfc/Papers/iee.ps.gz",
%  journal      = "IEE Proceedings-F",
%  month = dec, number = 6, pages = {362-370}, volume = 140, year = 1993}
%
%
%@article{JADE:NC,
%  author  = "Jean-Fran\c{c}ois Cardoso",
%  journal = "Neural Computation",
%  title   = "High-order contrasts for independent component analysis",
%  HTML    = "http://www.tsi.enst.fr/~cardoso/Papers.PS/neuralcomp_2ppf.ps",
%  year    = 1999, month =	jan,  volume =	 11,  number =	 1,  pages =	 "157-192"}
%
%
%
%
%  Notes:
%  ======
%
%  Note 1) The original Jade algorithm/code deals with complex signals in Gaussian noise
%  white and exploits an underlying assumption that the model of independent components
%  actually holds.  This is a reasonable assumption when dealing with some narrowband
%  signals.  In this context, one may i) seriously consider dealing precisely with the
%  noise in the whitening process and ii) expect to use the small number of significant
%  eigenmatrices to efficiently summarize all the 4th-order information.  All this is done
%  in the JADE algorithm.
%
%  In *this* implementation, we deal with real-valued signals and we do NOT expect the ICA
%  model to hold exactly.  Therefore, it is pointless to try to deal precisely with the
%  additive noise and it is very unlikely that the cumulant tensor can be accurately
%  summarized by its first n eigen-matrices.  Therefore, we consider the joint
%  diagonalization of the *whole* set of eigen-matrices.  However, in such a case, it is
%  not necessary to compute the eigenmatrices at all because one may equivalently use
%  `parallel slices' of the cumulant tensor.  This part (computing the eigen-matrices) of
%  the computation can be saved: it suffices to jointly diagonalize a set of cumulant
%  matrices.  Also, since we are dealing with reals signals, it becomes easier to exploit
%  the symmetries of the cumulants to further reduce the number of matrices to be
%  diagonalized.  These considerations, together with other cheap tricks lead to this
%  version of JADE which is optimized (again) to deal with real mixtures and to work
%  `outside the model'.  As the original JADE algorithm, it works by minimizing a `good
%  set' of cumulants.
%
%
%  Note 2) The rows of the separating matrix B are resorted in such a way that the columns
%  of the corresponding mixing matrix A=pinv(B) are in decreasing order of (Euclidian)
%  norm.  This is a simple, `almost canonical' way of fixing the indetermination of
%  permutation.  It has the effect that the first rows of the recovered signals (ie the
%  first rows of B*X) correspond to the most energetic *components*.  Recall however that
%  the source signals in S=B*X have unit variance.  Therefore, when we say that the
%  observations are unmixed in order of decreasing energy, this energetic signature is to
%  be found as the norm of the columns of A=pinv(B) and not as the variances of the
%  separated source signals.
%
%
%  Note 3) In experiments where JADE is run as B=jadeR(X,m) with m varying in range of
%  values, it is nice to be able to test the stability of the decomposition.  In order to
%  help in such a test, the rows of B can be sorted as described above. We have also
%  decided to fix the sign of each row in some arbitrary but fixed way.  The convention is
%  that the first element of each row of B is positive.
%
%
%  Note 4) Contrary to many other ICA algorithms, JADE (or least this version) does not
%  operate on the data themselves but on a statistic (the full set of 4th order cumulant).
%  This is represented by the matrix CM below, whose size grows as m^2 x m^2 where m is
%  the number of sources to be extracted (m could be much smaller than n).  As a
%  consequence, (this version of) JADE will probably choke on a `large' number of sources.
%  Here `large' depends mainly on the available memory and could be something like 40 or
%  so.  One of these days, I will prepare a version of JADE taking the `data' option
%  rather than the `statistic' option.


% JadeR.m ends here.