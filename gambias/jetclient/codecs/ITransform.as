package gambias.jetclient.codecs {
/**
 * An interface which is implemented by all codecs in gambias.jetclient.
 * @author Abraham Menacherry
 */
public interface ITransform {
    /**
     * ITransform one object to another. Can be used while encoding a message or decoding a message.
     * The classes that implement this interface can be used in "filter chains".
     * @param input the object to be converted to another object
     * @return This method returns the converted for of the object.
     */
    function transform(input:Object):Object;
}

}