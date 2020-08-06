
# MNT_PATH is the path you want to mount to the RSession
MNT_PATH=''
PROJECT="rstudio_rockr.simg"
PASSWORD='PULANSKIATNIGHT'

function help_menu () {
cat << EOF

Usage: ${0} {start|stop|run_rstudio|}
OPTIONS:
   -h|help             Show this message
   start
   stop
   run_rstudio
INFRASTRUCTURE:
   Build the infrastructure:
        $ ./bastion.sh start
   Check the status of the containers:
        $ ./bastion.sh status
   Stop the tutorial's infrastructure:
        $ ./bastion.sh stop
   Destroy all the resources related to the tutorial:
        $ ./bastion.sh destroy
   View the infrastructure logs:
        $ ./bastion.sh -l

EOF
}

function start_infrastructure () {
    singularity pull --name ${PROJECT} docker://rocker/geospatial
}
        
function stop_infrastructure () {
    singularity instance stop ${PROJECT}
}

function run_image () {
    PROJECT_FOLDER=$HOME
    PASSWORD=$PASSWORD singularity exec -B ${MNT_PATH}:/mnt \
        ${PROJECT} rserver --auth-none=0 \
        --auth-pam-helper-path=pam-helper \
        --www-address=127.0.0.1 #localhost
}

function all () {
	start_infrastructure
	run_image
}


if [[ $# -eq 0 ]] ; then
	help_menu
	exit 0
fi

case "$1" in
    start)
        start_infrastructure
		shift
        ;;
    stop)
        stop_infrastructure
		shift
        ;;
    run_rstudio)
        run_image
		shift
        ;;
    all)
        all
                shift
       ;;
    -h|--help)
        help_menu
                shift
        ;;
   *)
       echo "${1} is not a valid flag, try running: ${0} --help"
	   shift
       ;;
esac
shift

cd - > /dev/null
