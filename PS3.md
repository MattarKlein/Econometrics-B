% PS3
% Mattar Klein (328780168)

*All files can be found on my github at:*

*https://github.com/MattarKlein/Econometrics-B.git*

## Question 1

#### (a)
$$
E[D_i|Y_{1i},Y_{0i},X_i] = 1 \cdot P(D_i = 1|Y_{1i},Y_{0i},X_i)  + 0 \cdot P(D_i = 0|Y_{1i},Y_{0i},X_i)  = P(D_i = 1|Y_{1i},Y_{0i},X_i) 
$$

#### (b)
$$
E[D_i|Y_{1i},Y_{0i},p(X_i)] = E[E[D_i|Y_{1i},Y_{0i},p(X_i),X_i]] =  E[E[D_i|X_i]|Y_{1i},Y_{0i},p(X_i)]
$$

Where the second equality is b/c of the independence of $\{Y_{1i},Y_{0i}\}$ and $D_i|X_i$.

#### (c)
$$
E[D_i | X_i] = Pr(D_i = 1|X_i) = p(X_i)
$$
$$
\rightarrow E[D_i | Y_{1i}, Y_{0i},p(X_i)] = E[E[D_i|X_i]|Y_{1i},Y_{0i},p(X_i)] =
$$
$$
E[p(X_i)|Y_{1i},Y_{0i},p(X_i)] = p(X_i) = E[D_i | X_i]
$$

## Question 2

#### (a)

Import data

{{1}}


\newpage

Regress (linearly)observable characteristics on treatment in experimental data:

{{2}}


Repeat regression


{{3}}


I will now look at all the observables to see if they are blanced.

Results experimental



{{4}}

Results observational

{{5}}


After that long list it seems that the expermental is pretty balanced (after doing so many regressions it makes sense to have some things be statistically significant), however the observational data is not well balanced.

#### (b)
Run regression without and with controls

{{6}}



{{7}}


\newpage

Results - experimental

{{8}}


\newpage

Results - observational

{{9}}


The signs in the different datasets are oposite until controlling for all observables which is another sign that the observational data is not well balanced. Even then the effects in the expermiental data seem higher.

#### (c)

{{10}}


Results

{{11}}



{{12}}



![Density](dens.pdf)

It looks like everything is around 0. I will try to get a better picture by looking at <0.1.


{{13}}


![Density](dens2.pdf)

It seems that the control in this case is ditributed very differently from the treatment.

#### (d)


{{14}}


Columns (1) and (2) are the same regression on experimental data and observational data respectivley, restricted to propenisty score greater than 0.1. Columns (2) and (3) repeat the same thing for propenisty score greater than 0.2.

It seems that we are loosing a big part of the sample and the effects are still similar.

#### (e)


{{15}}


This is not feasible for the full sample b/c we have so many ppl close to 0 propensity scroe. For some reason I couldn't get the first regression to work I tried logit and probit, both refused to work. Other than that the results are similar.


## Question 3

## Import Data

{{16}}


#### (a)

{{17}}


It seems that the female wage gap only grows. And I mustve made a mistake somewhere b/c it seems that blacks are making more than whites?!?

#### (b)

It seems from the regression that they are. I don't know how to interpret for blacks (b/c everything there is backwards), but for female it seems that there might also be selection into eductaion.

#### (c)


{{18}}


This is the regression with occipational controls, it seems there hasn't been much change (although again the coeeficient on white is weird).

#### (d)

Year = 1990


{{19}}


Year = 1960

{{20}}


Column (1) is a regression with no controls, (2) with education controls and (3) with occupation controls. Again the coeeficient on white is weird and now female is all over the place 2. My guess is that the way I calculated the wage was not done very well.
