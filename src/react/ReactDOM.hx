package react;

import haxe.extern.EitherType;
import react.React.Component;
import react.React.ReactElement;
import js.html.Element;
import js.html.Text;

@:jsRequire('react-dom', 'default')
extern class ReactDOM {
	static function render(element:ReactElement<Dynamic>, container:Element, ?callback:Void->Void):Void;
	static function hydrate(element:ReactElement<Dynamic>, container:Element, ?callback:Void->Void):Void;
	static function unmountComponentAtNode(container:Element):Bool;
	static function findDOMNode(component:Component<Dynamic>):Null<EitherType<Element, Text>>;
	static function createPortal(child:ReactElement<Dynamic>, container:Element):ReactElement<Dynamic>;
}

@:jsRequire('react-dom/server', 'default')
extern class Server {
  static final version: String;
  static function renderToString(element:ReactElement<Dynamic>):String;
  static function renderToStaticMarkup(element:ReactElement<Dynamic>):String;
  #if nodejs
  static function renderToNodeStream(element:ReactElement<Dynamic>):js.node.stream.Readable.IReadable;
  static function renderToStaticNodeStream(element:ReactElement<Dynamic>):js.node.stream.Readable.IReadable;
  #end
}
