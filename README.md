# Visor Remoto
Software de controle de um sistema de visor desenvolvido com um raspberry, uma camera, um servo e uma tela com giroscopio (podendo ser utilizado o celular conectado ao rasp)

O sistema seria voltado para o motorista de um veículo blindado para que ele possa dirigir sem precisar se expôr.

## Interface Gráfica
Consiste, basicamente, de um player de vídeo que mostra a imagem da câmera.

![esboco](/documentação/esboco.png) 

## Diagrama de Classes
Para a interface gráfica, não foi criada nenhuma classe e não foi alterada nenhuma classe pré-existente do angular (AppModule, AppComponent, etc).

Para o Rasp, está sendo usado o programa MJPG-streamer para gerar a URL com o stream de videos e outro programa é responsável pelo controle do servo e orientação da câmera.

Para o controle do servo, foi pensado nessas 2 classes:

![diagramaBackEnd](/documentação/diagramaClassesBck.png)

E, para o frontend, pensando em exibir informações relevantes ao motorista (inicialmente pensados: orientação da câmera, velocidade do veículo, RPM do motor):

![diagramaBackEnd](/documentação/diagramaClassesFrnt.png)

### NOTA
Por falta de material (servo, suporte da câmera, tela e sensor giroscópio), o projeto se encontra, no momento, funcionando apenas na parte de transmissão do que a camera captura.

## Fluxograma
Como o código que roda no frontend não necessita de lógica (é apenas captura de dados e sua imediata exposição no html), temos que o fluxograma desse projeto pode ser resumido em:

![diagramaBackEnd](/documentação/fluxograma.png)

Que serve para reduzir movimentações desnecessárias da câmera.

## Como rodar
### Interface gráfica
Ter o angular instadado (npm install angular-cli)

- Rodar o comando, na pasta do projeto, para rodar o servidor da interface (localhost:4200)

'''bash
ng serve
'''

- Acessar <a href="http://localhost:4200" target="blank">localhost (http://localhost:4200)</a>. O padrão é rodar na porta 4200 (verificar terminal se realmente rodou nessa porta)

### Stream de Vídeo
Para o stream de vídeo foi utilizado o programa MJPG-Streamer que já captura a imagem da câmera e disponibiliza uma url localhost com o imagestream em jpeg.

- Instalar o MJPG Streamer
No seu raspberry rodar os comandos:

'''bash
cd /home/pi
git clone https://github.com/jacksonliam/mjpg-streamer.git
'''

para baixar as dependências do MJPG-Streamer

'''bash
sudo apt-get install cmake libjpeg8-dev
'''

Compile o código:

'''bash
cd mjpg-streamer/mjpg-streamer-experimental
make
sudo make install
'''

Com isso, o seu rasp já pode rodar um stream na rede local

- Instalando o Serviço
Para poder iniciar o stream de vídeo assim que o rasp é inicializado, é necessário criar um serviço no seu rasp. Para isso:

1. Extraia o arquivo start-camera.sh da pasta backend deste repositório para a pasta home/pi do seu rasp
1. Extraia o arquivo camera.service para a pasta lib/systemd/system
1. Rode os comandos
'''bash
sudo systemctl enable start-camera.service
sudo systemctl start start-camera.service
'''
para poder ativar o serviço


__***** NOTA: Não se esqueça de habilitar a câmera no seu rasp (configurações->Interfacing Options -> Camera - > Yes) *****__

__***** NOTA 2: Foi verificado que o browser chrome pode apresentar um Lag de 1.5s no feed do vídeo. *****__

__***** NOTA 3: Para alterar a qualidade da imagem e o fps, edite o arquivo start-camera.sh (última linha) *****__

### Servo Ctrl
Ter o python 3 instalado ([https://www.python.org/downloads/](https://www.python.org/downloads/))

- Rodar o comando, na pasta:

'''bash
python3 app.py (AINDA NÃO DESENVOLVIDO)
'''
  
__*****AINDA EM DESENVOLVIMENTO*****__
