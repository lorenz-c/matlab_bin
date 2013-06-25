function pred = ARIMA111(y)
    predictions=1;
    p=1;
    q=1;
    yy = y(1);
    y = diff(y);
    Spec = garchset('R',p,'M',q,'C',NaN,'VarianceModel','Constant');
    [EstSpec,EstSE] = garchfit(Spec,y);
    [sigmaForecast,meanForecast] = garchpred(EstSpec,y,predictions);
    pred = cumsum([yy; y; meanForecast])
    keyboard
    pred = pred(end-predictions+1:end);
end