#!/bin/bash
#
# setup kubectl for our Kraken clusters
#
# As long as the --kubeconfig arg points to the correct .kubeconfig file
# things will work.  NOTE: This is also to avoid the inconsistencies
# that can happen by depending on default locations for the .kubeconfig file.
#
# e.g.   what we want:
#alias kubectl='/opt/kubernetes/platforms/darwin/amd64/kubectl --kubeconfig="/Users/mikel_nelson/dev/cloud/kraken/kubernetes/.kubeconfig"'
#
VERSION="1.0"
function usage
{
    echo "Set Kubernetes kubectrl command with the correct .kubeconfig"
    echo ""
    echo "Usage:"
    echo "   . ./setmyenv.sh [flags]"
    echo ""
    echo "Flags:"
    echo "  -c, --cluster : local : [local, aws, ???] selects the cluster to use"
    echo "  -h, -?, --help :: print usage"
    echo "  -v, --version :: print script verion"
    echo ""
}
function version
{
    echo "./setmyenv.sh version $VERSION"
}
#
echo "--------------------------------------------"
echo "  Attempting to set a kubectl alias"
echo "  for Kraken."
echo ""
echo "  version: $VERSION"
echo "" 
echo " NOTE: You must 'source' this file"
echo "       so the alias will stick."
echo ""
echo " \$source ./setmyenv.sh"
echo "   or"
echo " \$. ./setmyenv.sh"
echo ""
unset CDPATH
#
# process args
#
CLUSTER_LOC="local"
TMP_LOC=$CLUSTER_LOC
while [ "$1" != "" ]; do
    case $1 in
        -c | --cluster )
            shift
            TMP_LOC=$1
            ;;
        -v | --version )
            version
            exit
            ;;
        -h | -? | --help )
            usage
            exit
            ;;
         * )
             usage
             exit 1
    esac
    shift
done
if [ -z "$TMP_LOC" ]; then
    echo ""
    echo "ERROR No Cluster Supplied"
    echo ""
    usage
    exit 1
else
    CLUSTER_LOC=$TMP_LOC
fi
echo "Using Kubernetes cluster: $CLUSTER_LOC"
echo "Locating Kraken Project kubectl and .kubeconfig..."
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#SCRIPTPATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
#cd ${SCRIPTPATH}
#KUBECONFIG=`find ${SCRIPTPATH}/${CLUSTER_LOC} -type f -name ".kubeconfig" -print | egrep 'kubernetes'`
#if [ $? -ne 0 ];then
#    echo "Could not find Kraken .kubeconfig in ${SCRIPTPATH}/${CLUSTER_LOC}"
#    exit 1
#else
#    echo "found: $KUBECONFIG"
#fi
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#KUBECTL=`find /opt/kubernetes/platforms/darwin/amd64 -type f -name "kubectl" -print | egrep '.*'`
KUBECTL=$( which kubectl )
if [ $? -ne 0 ];then
    echo "Could not find kubectl. Make sure you have kubectl in a path."
    exit 2
else
    echo "found: $KUBECTL"
fi
echo "Setting alias for kubectl with the kraken cluster ${CLUSTER_LOC}"
alias kub="${KUBECTL} --cluster=${CLUSTER_LOC}"
echo `alias kub`
echo "--------------------------------------------"
