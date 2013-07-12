package gambias.jetclient.event
{

    import flash.utils.Dictionary;

    /**
     * Integer versions of events are used to accept incoming events from remote jetserver and
     * to write back events to it. String versions are used for internal event dispatch from the session.
     * @author Abraham Menacherry
     */
    public class Events {
        // protocl version
        public static const JET_PROTOCOL:uint = 0x01;
        // Lifecycle events.
        public static const CONNECT:uint = 0x02;
        public static const CONNECT_EVENT:String = "JET-CONNECT";
        public static const CONNECT_FAILED:uint = 0x06;
        public static const CONNECT_FAILED_EVENT:String = "JET-CONNECT-FAILED";
        public static const LOG_IN:uint = 0x08;
        public static const LOG_IN_EVENT:String = "JET-LOG-IN";
        public static const LOG_OUT:uint = 0x0a;
        public static const LOG_OUT_EVENT:String = "JET-LOG-OUT";
        public static const LOG_IN_SUCCESS:uint = 0x0b;
        public static const LOG_IN_SUCCESS_EVENT:String = "JET-LOG-IN-SUCCESS";
        public static const LOG_IN_FAILURE:uint = 0x0c;
        public static const LOG_IN_FAILURE_EVENT:String = "JET-LOG-IN-FAILURE";
        public static const LOG_OUT_SUCCESS:uint = 0x0e;
        public static const LOG_OUT_SUCCESS_EVENT:String = "JET-LOG-OUT-SUCCESS";
        public static const LOG_OUT_FAILURE:uint = 0x0f;
        public static const LOG_OUT_FAILURE_EVENT:String = "JET-LOG-OUT-FAILURE";

        // Metadata events
        public static const GAME_LIST:uint = 0x10;
        public static const GAME_LIST_EVENT:String = "JET-GAME-LIST";
        public static const ROOM_LIST:uint = 0x12;
        public static const ROOM_LIST_EVENT:String = "JET-ROOM-LIST";
        public static const GAME_ROOM_JOIN:uint = 0x14;
        public static const GAME_ROOM_JOIN_EVENT:String = "JET-GAME-ROOM-JOIN";
        public static const GAME_ROOM_LEAVE:uint = 0x16;
        public static const GAME_ROOM_LEAVE_EVENT:String = "JET-GAME-ROOM-LEAVE";
        public static const GAME_ROOM_JOIN_SUCCESS:uint = 0x18;
        public static const GAME_ROOM_JOIN_SUCCESS_EVENT:String = "JET-GAME-ROOM-JOIN-SUCCESS";
        public static const GAME_ROOM_JOIN_FAILURE:uint = 0x19;
        public static const GAME_ROOM_JOIN_FAILURE_EVENT:String = "JET-GAME-ROOM-JOIN-FAILURE";

        /**
         * Event sent from server to client to start message sending from client to server.
         */
        public static const START:uint = 0x1a;
        public static const START_EVENT:String = "JET-START";
        /**
         * Event sent from server to client to stop messages from being sent to server.
         */
        public static const STOP:uint = 0x1b;
        public static const STOP_EVENT:String = "JET-STOP";
        /**
         * Incoming data from another machine/JVM to this JVM (server or client)
         */
        public static const SESSION_MESSAGE:uint = 0x1c;
        public static const SESSION_MESSAGE_EVENT:String = "JET-SESSION-MESSAGE";

        /**
         * Outgoing data from the client to jetserver.
         */
        public static const NETWORK_MESSAGE:uint = 0x1d;
        public static const NETWORK_MESSAGE_EVENT:String = "JET-NETWORK-MESSAGE";
        public static const CHANGE_ATTRIBUTE:uint = 0x20;
        public static const CHANGE_ATTRIBUTE_EVENT:String = "JET-CHANGE-ATTRIBUTE";

        /**
         * If a remote connection is disconnected or closed then raise this event.
         */
        public static const DISCONNECT:uint = 0x22;
        public static const DISCONNECT_EVENT:String = "JET-DISCONNECT";
        public static const EXCEPTION:uint = 0x24;
        public static const EXCEPTION_EVENT:String = "JET-EXCEPTION";

        /**
         * This map is used for translating the byte event type to a string.
         */
        public static const EVENT_LOOKUP_MAP:Dictionary = new Dictionary();

        public static function convertEventTypeToString(eventType:int):String {
            var count:int = 0;
            for (var key:Object in EVENT_LOOKUP_MAP) {
                count++;
                break;
            }

            if (count == 0) {
                EVENT_LOOKUP_MAP[CONNECT] = CONNECT_EVENT;
                EVENT_LOOKUP_MAP[CONNECT_FAILED] = CONNECT_FAILED_EVENT;
                EVENT_LOOKUP_MAP[LOG_IN] = LOG_IN_EVENT;
                EVENT_LOOKUP_MAP[LOG_OUT] = LOG_OUT_EVENT;
                EVENT_LOOKUP_MAP[LOG_IN_SUCCESS] = LOG_IN_SUCCESS_EVENT;
                EVENT_LOOKUP_MAP[LOG_IN_FAILURE] = LOG_IN_FAILURE_EVENT;
                EVENT_LOOKUP_MAP[LOG_OUT_SUCCESS] = LOG_OUT_SUCCESS_EVENT;
                EVENT_LOOKUP_MAP[LOG_OUT_FAILURE] = LOG_OUT_FAILURE_EVENT;
                EVENT_LOOKUP_MAP[GAME_LIST] = GAME_LIST_EVENT;
                EVENT_LOOKUP_MAP[ROOM_LIST] = ROOM_LIST_EVENT;
                EVENT_LOOKUP_MAP[GAME_ROOM_JOIN] = GAME_ROOM_JOIN_EVENT;
                EVENT_LOOKUP_MAP[GAME_ROOM_LEAVE] = GAME_ROOM_LEAVE_EVENT;
                EVENT_LOOKUP_MAP[GAME_ROOM_JOIN_SUCCESS] = GAME_ROOM_JOIN_SUCCESS_EVENT;
                EVENT_LOOKUP_MAP[GAME_ROOM_JOIN_FAILURE] = GAME_ROOM_JOIN_FAILURE_EVENT;
                EVENT_LOOKUP_MAP[START] = START_EVENT;
                EVENT_LOOKUP_MAP[STOP] = STOP_EVENT;
                EVENT_LOOKUP_MAP[SESSION_MESSAGE] = SESSION_MESSAGE_EVENT;
                EVENT_LOOKUP_MAP[NETWORK_MESSAGE] = NETWORK_MESSAGE_EVENT;
                EVENT_LOOKUP_MAP[CHANGE_ATTRIBUTE] = CHANGE_ATTRIBUTE_EVENT;
                EVENT_LOOKUP_MAP[DISCONNECT] = DISCONNECT_EVENT;
                EVENT_LOOKUP_MAP[EXCEPTION] = EXCEPTION_EVENT;
            }

            return EVENT_LOOKUP_MAP[eventType];
        }
    }

}