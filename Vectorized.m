%    Develop a vectorized version of the following code (제시된 m-code를 vectorization하라.) 
%         tstart = 0; tend = 20; ni = 8;
%         t(1) = tstart;
%         y(1) = 12 + 6*cos(2*pi*t(1)/(tend-tstart));
%         for i = 2 : ni+1
%             t(i) = t(i-1)+(tend-tstart)/ni;
%             y(i) = 10 + 5*cos(2*pi*t(i)/ (tend-tstart));
%         end
tstart = 0; tend = 20; ni = 8;
t(1) = tstart;
y(1) = 12 + 6*cos(2*pi*t(1)/(tend-tstart));
for i = 2 : ni+1
    t(i) = t(i-1)+(tend-tstart)/ni;
    y(i) = 10 + 5*cos(2*pi*t(i)/ (tend-tstart));
end

% line 13 --> parameter 설정
% line 14 --> array t의 첫번째 요소 값 결정
% line 15 --> 출력에 해당하는 array y의 첫번째 요소 값 결정 <-- 이를 계산하는데 t(1)
% line 16 --> 반복 계산이 시작됨.
% line 17 --> array t의 두번째, 세번째 요소 값들이 반복 과정에서 순차적으로 결정
% line 18 --> line 17에서 계산된 새로운 t 값(새로운 요소 값)을 이용하여 출력 y를 결정
%                <-- array y의 두번째, 세번째 요소 값이 반복 과정에서 순차적으로 계산됨.
% 분석 끝

% 여러 t 값에 대해 y값들을 계산
% 여러 t 값을 array로 미리 선언하고 값을 assignment
% tstart ~ tend (간격은 (tend-tstart)/ni)
t = [tstart : (tend - tstart)/ni : tend]';
y = 10 + 5 * cos ( 2 * pi * t / (tend-tstart));
y(1) = 12 + 6*cos(2*pi*t(1)/(tend-tstart));

% 동작 결과를 그래프로
plot(t, y, 'ro');
xlabel( 'x' ); ylabel( 'y' );
