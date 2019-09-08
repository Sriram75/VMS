echo "Setting up the network.."                                                                                                                                                                                                                                                                              
echo "peer0.owner.siam.com joined the channel"

echo "Installing siam chaincode to peer0.manufacturer.siam.com..."

# install chaincode
# Install code on manufacturer peer
docker exec -e "CORE_PEER_LOCALMSPID=manufacturerMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/manufacturer.siam.com/users/Admin@manufacturer.siam.com/msp" -e "CORE_PEER_ADDRESS=peer0.manufacturer.siam.com:7051" cli peer chaincode install -n siamcc -v 1.0 -p github.com/siam/go -l golang

echo "Installed siam chaincode to peer0.manufacturer.siam.com"



echo "Installing siam chaincode to peer0.rto.siam.com...."

# Install code on rto peer
docker exec -e "CORE_PEER_LOCALMSPID=rtoMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/rto.siam.com/users/Admin@rto.siam.com/msp" -e "CORE_PEER_ADDRESS=peer0.rto.siam.com:7051" cli peer chaincode install -n siamcc -v 1.0 -p github.com/siam/go -l golang

echo "Installed siam chaincode to peer0.rto.siam.com"

echo "Installing siam chaincode to peer0.owner.siam.com..."
# Install code on owner peer
docker exec -e "CORE_PEER_LOCALMSPID=ownerMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/owner.siam.com/users/Admin@owner.siam.com/msp" -e "CORE_PEER_ADDRESS=peer0.owner.siam.com:7051" cli peer chaincode install -n siamcc -v 1.0 -p github.com/siam/go -l golang

echo "Installed siam chaincode to peer0.owner.siam.com"



echo "Installing tfbc chaincode to peer0.scrp.siam.com..."
# Install code on scrp peer
docker exec -e "CORE_PEER_LOCALMSPID=scrpMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/scrp.siam.com/users/Admin@scrp.siam.com/msp" -e "CORE_PEER_ADDRESS=peer0.scrp.siam.com:7051" cli peer chaincode install -n siamcc -v 1.0 -p github.com/tfbc/go -l golang
echo "Installed siam chaincode to peer0.scrp.siam.com"



sleep 5

 

echo "Instantiating siam chaincode.."

docker exec -e "CORE_PEER_LOCALMSPID=manufacturerMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/manufacturer.siam.com/users/Admin@manufacturer.siam.com/msp" -e "CORE_PEER_ADDRESS=peer0.manufacturer.siam.com:7051" cli peer chaincode instantiate -o orderer.siam.com:7050 -C siamchannel -n siamcc -l golang -v 1.0 -c '{"Args":[""]}' -P "OR ('manufacturerMSP.member','rtoMSP.member','ownerMSP.member','scrpMSP.member')"

echo "Instantiated siam chaincode."

echo "Following is the docker network....."