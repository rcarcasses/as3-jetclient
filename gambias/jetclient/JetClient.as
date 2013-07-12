package gambias.jetclient
{
    import flash.events.*;
    import flash.net.Socket;
    import flash.utils.ByteArray;

    import gambias.jetclient.event.Events;
    import gambias.jetclient.event.SocketDataEvent;

    import gambias.jetclient.protocols.IProtocol;

    /**
     * Used to create a TCP socket connection to remote Jetserver.
     * @author Abraham Menacherry
     */
    public class JetClient extends EventDispatcher
    {


        private var _socket:Socket;

        private var _remoteHost:String;
        private var _remotePort:int;
        private var _protocol:IProtocol;
        private var _username:String;
        private var _password:String;
        private var _connectionKey:String;

        public function JetClient(remoteHost:String, remotePort:int, protocol:IProtocol)
        {
            this._remoteHost = remoteHost;
            this._remotePort = remotePort;
            this._protocol = protocol;

            _socket = new Socket(remoteHost, remotePort);
            _socket.addEventListener(Event.CONNECT, socketConnect);
            _socket.addEventListener(Event.CLOSE, socketClose);
            _socket.addEventListener(IOErrorEvent.IO_ERROR, socketError);
            _socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
            _socket.addEventListener(ProgressEvent.SOCKET_DATA, socketData);
        }

        public function connect(username:String, password:String = '', connectionKey:String = ''):Socket
        {
            _username = username;
            _password = password;
            _connectionKey = connectionKey;

            try
            {
                trace('[INFO][JetClient:connect()] Connecting to ', _remoteHost, ':', _remotePort, ' ...');
                _socket.connect(_remoteHost, _remotePort);

            } catch (error:Error)
            {
                /*
                 *   Unable to connect to remote server, display error
                 *   message and close connection.
                 */
                trace('[ERROR][JetClient:connect()] Unable to connect to remote server:\n', error.message);
                _socket.close();
                throw (error);
            }

            return _socket;
        }

        public function newGamePacket(packet:ByteArray):void
        {
            //a game packet can be formed by several TCP packets
            trace('[INFO][JetClient:newGamePacket()] New game packet received, processing...');
        }

        public function socketConnect(event:Event):void
        {
            trace('[INFO][JetClient:socketConnect()] Connected, log in...');

            var loginData:Object = {
                                        type:Events.LOG_IN,
                                        username:_username,
                                        password:_password,
                                        fbToken:_connectionKey,
                                        gameRoom:"BaseballGameLobby",
                                        reconnectKey:"_empty_"
                                    };
            sendObject(loginData);
        }

        public function sendObject(data:Object):void
        {
            trace('[INFO][JetClient:sendObject()] Sending', JSON.stringify(data));
            send(_protocol.write(data));
        }

        private function send(bytes:ByteArray):void
        {
            _socket.writeBytes(bytes);
            _socket.flush();
        }

        public function socketData(event:ProgressEvent):void
        {
            trace('[INFO][JetClient:socketData()] Data received');
            var newData:ByteArray = new ByteArray();
            _socket.readBytes(newData);

            //translate the data with the protocol read
            _protocol.read(newData, dataReceived);
        }

        private function dataReceived(data:Object):void
        {
            trace('[INFO][JetClient:dataReceived()] New data\n', JSON.stringify(data), '\n');
            dispatchEvent(SocketDataEvent.getSocketDataEvent(data));
        }

        public function socketClose(event:Event):void
        {
            trace('[INFO][JetClient:socketClose()] Connection close');
        }

        public function socketError(event:IOErrorEvent):void
        {
            trace('[ERROR][JetClient:socketError()] Socket error:\n', event);
        }

        public function securityError(event:SecurityErrorEvent):void
        {
            trace('[ERROR][JetClient:securityError()] Security error:\n', event);
        }
    }

}