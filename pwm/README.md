# Estabilizador Inercial
Estabiliza��o de uma plantaforma utilizando motor DC e a STM32F4 Discovery. 
## Conceito e Motiva��o
Plataformas inercialmente estabilizadas s�o aplicadas para apontar e estabilizar a linha de visada de diversos tipos de sensores, c�meras, telesc�pios, antenas de comunica��o e armamentos. Objetiva-se estabilizar uma plataforma com motor DC utilizando a STM32F4 Discovery e o aceler�metro/giroc�pio MPU-9250. Para tal, ser� feita a modelagem do motor e implementa��o de um controle PID, embarcado na placa, controle esse com constantes que podem ser ajustadas via serial e posterior desenvolvimento de um prot�tipo funcional.
##### Motiva��o Secund�ria
Poder realizar a medi��o da acelera��o e da velocidade com que qualquer corpo est� se movendo. Como por exemplo realizar essas medi��es para os rob� da equipe roboime da categoria SSL de futebol de rob�s. Assim tendo uma maneira alternativa para a realimenta��o de sua malha de controle.

## Descri��o do Problema

Faremos uma simplifica��o para um problema envolvendo apenas um grau de liberdade. O sistema est� representado na figura abaixo:

![Ilustra��o-do-sistema](sistema.png)

O objetivo ser� estabilizar a dire��o da linha de visada da plataforma, $$\theta_{pI}$$, em um valor fixo de refer�ncia $$\theta_{r}$$, tipicamente $$0\,^{\circ}$$. Onde a haste poder� se mover livremente em um certo intervalo angular e o motor exercer� o papel de se contrapor ao seu movimento estabilizando a plataforma. Assim:

$$\theta_{pI} = \theta_{ph} + \theta_{hI} = \theta_{r}$$

Fixando o sensor inercial na plataforma pode-se medir diretamente o �ngulo que queremos estabilizar, $$\theta_{pI}(t)$$. Conforme � mostrado na figura abaixo, controlamos a vari�vel $$\theta_{ph}(t)$$ por meio do motor e o movimento da haste, $$\theta_{hI}(t)$$, � visto como uma pertuba��o na sa�da do sistema. Desse modo n�o se faz necess�rio o uso de encoders, uma vez que n�o precisamos medir o sinal $$\theta_{ph}(t)$$. Como o sensor inercial mede diretamente a dire��o da linha de visada da plataforma, � poss�vel a corre��o de dist�rbios que atuem em cima da plataforma.

![Diagrama-de-blocos-de-sistema](DiagramaBlocosSistema.png)

A sa�da $$y(t) = \theta_{pI}(t)$$ deve tentar alcan�ar o sinal de entrada/refer�ncia $$r(t) = \theta_{r}(t)$$ e rejeitar a perturba��o $$w(t) = \theta_{hI}(t)$$. Dessa forma temos a fun��o de transfer�ncia do sistema, onde C(s) e P(s) s�o as fun��es de transfer�ncia do controlador e da planta respectivamente:

$$\frac{Y(s)}{R(s)} = \frac{C(s)P(s)}{1 + C(s)P(s)}$$

## Diagrama de Blocos do Projeto

Para base de produ��o do fimrware ser� utilizada uma placa produzida pelo Aluno Onias Castelo, membro da RoboIME com suporte da IMBEL-FMCE e uma STM32F4Discovery produzida pela ST. A placa conta com, al�m do MPU-9250, um extensor de porta STMPE811, via I2C conectado a um display de 7-segmentos, um bot�o, dois LEDs e um conector para cart�o microSD. Al�m disso ser� utilizado um motor e um m�dulo de motor.

![Placa](placa.PNG)

Os perif�ricos a serem utilizados se comunicaram com o microcontrolador de acordo com o diagrama de blocos abaixo.

![Diagrama-de-blocos](diagramablocos.PNG)

### Interface com o Usu�rio

Ser� feita uma interface em labview para q a resposta do sistema possa ser visualizada e em tempo real as constantes da malha de controle ajustadas.
 
## Refer�ncias

[MPU-9250 Datasheet][mpu]

[STM32F4Discovery][stm32f4]

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [mpu]: <https://www.invensense.com/products/motion-tracking/9-axis/mpu-9250/>
   [globo-esporte]: <http://globoesporte.globo.com/eu-atleta/saude/noticia/2016/03/voce-sabe-o-que-e-cadencia-da-corrida-e-como-ela-pode-ajudar.html>
   [stm32f4]: <http://www.st.com/en/evaluation-tools/stm32f4discovery.html#sw-tools-scroll>
   [stmpe811]: <https://br.mouser.com/datasheet/2/389/stmpe811-1309299.pdf>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>      
   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]: <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
   [PlMe]: <https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md>
   [PlGa]: <https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md>
