%Make resample.


    n=30;
    p1=randn(n,2);
    w1=rand(n,1);
    
    p2=randn(n,2);
    %w2=rand(n,1);
    w2=1-w1
    
    
    figure(1)
        plot(p1(:,1),p1(:,2),'kx')
        hold on;
        plot(p2(:,1),p2(:,2),'ok')
        hold off;
        set(gca,'FontSize',14,'FontName','Times')
        xlabel('x [m]')
        xlabel('y [m]')
        
    figure(2)
        w1=w1/sum(w1);
        w2=w2/sum(w2);
    
        w3=w1.*w2;
        w3=w3/sum(w3);
        [p11,w11]=resampleSingle(p1,w1);
        %[p21,w21]=resampleSingle(p2,w1);
        %[p12,w12]=resampleSingle(p1,w2);
        [p22,w22]=resampleSingle(p2,w2);
        
        [p13,w13]=resampleSingle(p1,w3);
        [p23,w23]=resampleSingle(p2,w3);
        
        plot(p11(:,1),p11(:,2),'kx')
        hold on;
        plot(p22(:,1),p22(:,2),'ko')
        plot(p13(:,1),p13(:,2),'ks')
        plot(p23(:,1),p23(:,2),'k.')
        hold off;
        set(gca,'FontSize',14,'FontName','Times')
        xlabel('x [m]')
        xlabel('y [m]')
    
    figure(3)
        vect=1:numel(w1);
        plot(w1,'b')
        hold on;
        indsw1=w1>1.5*mean(w1);
        plot(vect(indsw1),w1(vect(indsw1)),'bo')
        
        plot(w2,'r')
        indsw2=w2>1.5*mean(w2);
        plot(vect(indsw2),w2(vect(indsw2)),'ro')
        
        plot(w3,'k')
        indsw3=w3>1.5*mean(w3);
        indsw3=indsw3 & indsw2 & indsw1;
        plot(vect(indsw3),w3(vect(indsw3)),'ko')
        hold off
        set(gca,'FontSize',14,'FontName','Times')
        xlabel('Particle [n]')
        ylabel('Weight []')
        print(gcf,'Depletion.eps','-depsc')
        
        
        for a1=1:10
            w1=rand(n,1);
            w2=1-w1;
            [p11,w11]=resampleSingle(p11,w1);
            [p22,w22]=resampleSingle(p22,w2);
            w3=w1.*w2;
            w3=w3/sum(w3);
            [p13,w13]=resampleSingle(p11,w3);
            [p23,w13]=resampleSingle(p22,w3);
            figure(4)
            rr=0.1*randn(n,2);
            
            p11=p11+rr;
            p22=p22-rr;
            
            plot(p11(:,1),p11(:,2),'ks')
            hold on;
            plot(p22(:,1),p22(:,2),'rs')
            
            plot(p13(:,1),p13(:,2),'k.','markersize',20)
            plot(p23(:,1),p23(:,2),'r.','markersize',20)
            mup11=mean(p11);
            mup22=mean(p22);
            mup13=mean(p13);
            mup23=mean(p23);
            plot(mup11(:,1),mup11(:,2),'ks','markersize',20)
            plot(mup22(:,1),mup22(:,2),'rs','markersize',20)
            plot(mup13(:,1),mup13(:,2),'ko','markersize',20)
            plot(mup23(:,1),mup23(:,2),'ro','markersize',20)
            plot(mup11(:,1)+0.05*randn,mup11(:,2)-0.05*randn,'kx','markersize',30)
            plot(mup22(:,1)+0.05*randn,mup22(:,2)-0.05*randn,'rx','markersize',30)
            hold off;
            set(gca,'FontSize',14,'FontName','Times')
            xlabel('x [m]')
            ylabel('y [m]')
            %pause(1)
            
            
        end
        
        print(gcf,'IndependentlySampled.eps','-depsc')