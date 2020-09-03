function basic_hist_plot_custom_bins(data,title_str,x_str )

if isempty(data)
    return
end

N1 = sum(data>0);
N2 = sum(data<0);

p_sign = signtest(data);
[h,p_t] = ttest(data);

Nc = sum(~isnan(data));
nbins = max(10,floor(2*sqrt(Nc)));
range = (max(data(:)) -  min(data(:)));
bin_step = 0.1;
bins1 = [0:-bin_step:-1];
bins2 = [bin_step:bin_step:1];
bins = [fliplr(bins1) bins2];
if isempty(bins)
    bins = length(data);
end
[N,C] = hist(data,bins);
barh = bar(C,N);
barh.FaceColor = 'k';
hold all

xlabel(x_str)
xrange = get(gca,'XLim'); yrange = get(gca,'YLim');
lineh = line([0 0], [0 yrange(2)],'color','k','linewidth',2);

M1 = nanmedian(data);
M2 = nanmean(data);
plot(M1,-0.5,'r^','markersize',15,'MarkerFaceColor','r')
plot(M2,-0.5,'g^','markersize',15,'MarkerFaceColor','g')
if( ~isempty(title_str))
    title(sprintf('%s  - \np(sign test) = %0.2e,p(ttest) = %0.2e',...
        title_str,p_sign,p_t))
else
    title(sprintf('p(sign-test) = %0.4f, p(ttest) = %0.4f',...
        p_sign,p_t))
end
axis([-1.1 1.1 -1 yrange(2)])
set(gca,'ytick',[0:5:yrange(2)]);
set(gca,'xtick',[-1 0 1]);

xrange = get(gca,'XLim'); yrange = get(gca,'YLim');
text(diff(xrange)/8,yrange(2)-diff(yrange)/5,num2str(N1),'fontweight','bold')
text(-diff(xrange)/8,yrange(2)-diff(yrange)/5,num2str(N2),'fontweight','bold')
% text(xrange(1)+diff(xrange)/10,yrange(2)-diff(yrange)/7,sprintf('Mean=%2.2e\nMedian=%2.2e',M2,M1),'fontweight','bold')

end