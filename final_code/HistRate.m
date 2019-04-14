function result = HistRate(x)
%???HistRate(x)��ͳ������ x �е�Ԫ�س��ֵ�Ƶ����Ƶ�ʺ��ۻ�Ƶ�ʣ��Ա�����ʽ��ʾ����Ļ��.
%???x��������ֵ�����顢�ַ������ַ������顢�ַ���Ԫ�����������߶����顣
%
%???result = HistRate(x)�����ؾ����Ԫ������result�����Ƕ���4�еľ����Ԫ�����飬
%???���зֱ��Ӧȡֵ��Ƶ����Ƶ�ʡ��ۻ�Ƶ�ʡ���x����ֵ������ʱ��resultΪ���󣻵�x
%???���ַ������ַ������顢�ַ���Ԫ�����������߶�����ʱ��resultΪԪ�����顣
%
%???�û����ɲο�tabulate�������ú�����tabulate������Ч�ʸߡ�
%??
%???Copyright xiezhh��2010.3.8
if isnumeric(x)
    x = x(:);
    x = x(~isnan(x));
    xid = [];
else
    [x,xid] = grp2idx(x);
    x = x(~isnan(x));
end
x = sort(x(:));% ����
m = length(x);
x1 = diff(x);% ����
x1(end + 1) = 1;
x1 = find(x1);
CumFreq = x1/m;
value = x(x1);
x1 = [0; x1];
Freq1 = diff(x1);
Freq2 = Freq1/m;
if nargout == 0
    if isempty(xid)
        fmt1 = '66666';
        fmt2 = '77777';
    else
        head = {'num', 'count', 'Freq(%)', 'CumFreq(%)'};
        [head;xid,num2cell([Freq1, 100*Freq2, 100*CumFreq])]
    end
else
    if isempty(xid)
        result = [value Freq1];
    else
        result = [xid,num2cell([Freq1, Freq2, CumFreq])];
    end
end