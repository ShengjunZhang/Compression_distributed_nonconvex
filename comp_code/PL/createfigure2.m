function createfigure2(ymatrix1)
%CREATEFIGURE2(ymatrix1)
%  YMATRIX1:  bar matrix data

%  Auto-generated by MATLAB on 14-Sep-2022 17:20:19

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to bar
bar1 = bar(ymatrix1,'Horizontal','on','BarLayout','stacked','Parent',axes1);
    set(bar1(10),'FaceColor',[0.18,0.18,0.53]); %
    set(bar1(9),'FaceColor',[0.8,0.4,0.4]); %
    set(bar1(8),'FaceColor',[1.0,0.65,0.0]);%
    set(bar1(7),'FaceColor',[0.69,0.75,0.1]);%
    set(bar1(6),'FaceColor',[0.0,0.5,0.0]);%
    set(bar1(5),'FaceColor',[0.88,0.24,0.19]);%
    set(bar1(4),'FaceColor',[0.5,0.09,0.09]);%
    set(bar1(3),'FaceColor',[0.5,0.0,0.5]); %
    set(bar1(2),'FaceColor',[0.36,0.68,0.93]); %
    set(bar1(1),'FaceColor','k');

% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0.5 10.5]);
box(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'FontSize',12,'TickLabelInterpreter','latex','YTick',...
    [1 2 3 4 5 6 7 8 9 10],'YTickLabel',...
    {'DPDA','Algorithm 2-$\mathcal{C}_3$','Algorithm 2-$\mathcal{C}_2$','Algorithm 1-$\mathcal{C}_1$','Algorithm 3-$\mathcal{C}_3$','Algorithm 1-$\mathcal{C}_3$','Algorithm 1-$\mathcal{C}_2$','Algorithm 3-$\mathcal{C}_2$','Algorithm 3-$\mathcal{C}_4$','Algorithm 3-$\mathcal{C}_5$'});
% Create textbox
annotation(figure1,'textbox',...
    [0.183714290758929 0.84714287022182 0.107142859271595 0.0676189909435455],...
    'Color',[0.18 0.18 0.53],...
    'String','3.80%',...
    'FontWeight','bold',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.20121429375 0.762857302711124 0.107142859271595 0.0676189909435455],...
    'Color',[0.8 0.4 0.4],...
    'String','6.37%',...
    'FontWeight','bold',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.226928594449404 0.680952415466314 0.107142859271594 0.0676189909435455],...
    'Color',[1 0.65 0],...
    'String','10.17%',...
    'FontWeight','bold',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.228142891994047 0.600952489217125 0.107142859271595 0.0676189909435474],...
    'Color',[0.69 0.75 0.1],...
    'String','10.17%',...
    'FontWeight','bold',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.240500049970238 0.519047679719471 0.107142859271594 0.0676189909435466],...
    'Color',[0 0.5 0],...
    'String','11.89%',...
    'FontWeight','bold',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.239785754166666 0.437142831348239 0.107142859271595 0.0676189909435456],...
    'Color',[0.88 0.24 0.19],...
    'String','11.89%',...
    'FontWeight','bold',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.246214320119047 0.354761933281309 0.107142859271593 0.0676189909435466],...
    'Color',[0.5 0.09 0.09],...
    'String','12.55%',...
    'FontWeight','bold',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.613357172619047 0.275238153911772 0.107142859271595 0.0676189909435463],...
    'Color',[0.5 0 0.5],...
    'String','62.84%',...
    'FontWeight','bold',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.686214230952381 0.193809588477725 0.107142859271594 0.0676189909435462],...
    'Color',[0.36 0.68 0.93],...
    'String','72.88%',...
    'FontWeight','bold',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);
