#!/bin/sh
# Descarga los vídeos de la web a la carpeta video/.
# Se ejecuta una vez, antes de publicar:  sh videos.sh
# Mientras no estén en video/, la web los carga desde la copia remota (ver VIDEO_REMOTE en index.html).
cd "$(dirname "$0")" || exit 1
mkdir -p video
B="https://d2ol7oe51mr4n9.cloudfront.net/user_3JEdsYjd5OrgQ3CLgWpic3aAmft"
fail=0
get() {
  printf '· %s ' "$2"
  if curl -fsSL --retry 2 -o "video/$2.part" "$B/$1.mp4" && [ -s "video/$2.part" ]; then
    mv "video/$2.part" "video/$2"; echo "ok"
  else
    rm -f "video/$2.part"; echo "NO SE PUDO DESCARGAR"; fail=1
  fi
}
get 7b804292-2b65-4aa9-a53c-9cbb06577d23 clinica.mp4
get 496a132c-1bae-47fa-87db-73e524245551 taller.mp4
get a4ca3be8-2ab7-49ed-81b6-e3b9c4da9ea0 agencia.mp4
get d02288fb-b8e2-404b-860f-f5f76c46feb2 academia.mp4
get 1910d612-e974-4be1-a27a-9061f1d66583 banda.mp4
get 752b7110-dffa-41bd-8790-3e2de6cc3e6f banda-movil.mp4
[ "$fail" = 0 ] && echo "Listo: vídeos en video/" || echo "Algún vídeo no se descargó; la web usará la copia remota para ese."
exit 0
