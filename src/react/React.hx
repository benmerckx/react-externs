package react;

import haxe.extern.EitherType;
import haxe.extern.Rest;
import haxe.Constraints.Function;
import js.lib.Promise;
import js.lib.Error;

typedef OneOf<A, B> = EitherType<A, B>;
typedef Key = OneOf<String, Int>;
typedef ReactElement<P> = {
	type:Dynamic,
	props:P,
	?key:Key
}
typedef ReactNode = Dynamic;
typedef ExoticComponent<P> = Dynamic;
typedef Ref<T> = OneOf<MutableRefObject<T>, OneOf<RefObject<T>, T->Void>>;
typedef RefObject<T> = {final current: T;}
typedef MutableRefObject<T> = {current: T}
typedef ComponentClass<P> = Class<Component<P>>;
typedef FunctionComponent<P> = P -> ReactNode;
typedef ComponentType<P> = OneOf<FunctionComponent<P>, ComponentClass<P>>;
typedef CreateElement<P> = OneOf<String, ComponentType<P>>;
typedef Context<T> = {
	Provider: ExoticComponent<{value: T}>,
	Consumer: ExoticComponent<{?children: (value: T) -> ReactNode}>,
	?displayName: String
}
typedef Dispatch<A> = (value: A) -> Void;
typedef SetStateAction<S> = OneOf<S, (prevState: S) -> S>;
typedef Pair<A, B> = Array<OneOf<A, B>>;
typedef SuspenseProps = {
  ?children: ReactNode,
  fallback:ReactNode
}
typedef EffectCallback = OneOf<() -> Void, () -> (() -> Void)>;
typedef DependencyList = Array<Dynamic>;
typedef Reducer<S, A> = (prevState: S, action: A) -> S;
typedef ImportedModule<T> = Dynamic; //{default: T}

@:jsRequire('react')
extern class React {
	static final version:String;

	static function createElement<P>(type:CreateElement<P>, ?props:Dynamic, children:Rest<ReactNode>):ReactElement<P>;
	static function cloneElement<P>(element:ReactElement<P>, ?attrs:Dynamic, children:Rest<ReactNode>):ReactElement<P>;
	static function isValidElement(object:Dynamic):Bool;
	static function createContext<T>(?defaultValue:T):Context<T>;
	static function createRef<T>():Ref<T>;
	static function forwardRef<P, R>(render:P->Ref<R>->ReactElement<P>):CreateElement<P>;

	static final Children:ReactChildren;
	static final Fragment:ExoticComponent<{?children:ReactNode}>;
	static final StrictMode:ExoticComponent<{?children:ReactNode}>;
  static final Suspense:ExoticComponent<SuspenseProps>;
  
  static function memo<P, T: ComponentType<P>>(
    factory: () -> Promise<ImportedModule<T>>
  ): ComponentType<P>;
  static function lazy<P, T: ComponentType<P>>(
    factory: () -> Promise<ImportedModule<T>>
  ): ComponentType<P>;

	static function useState<S>(initialState: OneOf<S, () -> S>): Pair<S, Dispatch<S>>;
	static function useEffect(effect: EffectCallback, ?deps: DependencyList): Void;
	static function useLayoutEffect(effect: EffectCallback, ?deps: DependencyList): Void;
	static function useContext<T>(context: Context<T>): T;
	static function useReducer<S, A, I>(
		reducer: Reducer<S, A>,
		initializerArg: I,
		?initializer: (arg: I) -> S
	): Pair<S, Dispatch<S>>;
	static function useCallback<T: Function>(callback: T, deps: DependencyList): T;
	static function useMemo<T>(factory: () -> T, deps: DependencyList): T;
	static function useRef<T>(initialValue: T): MutableRefObject<T>;
	static function useDebugValue<T>(value: T, ?format: (value: T) -> Dynamic): Void;
	static function useImperativeHandle<T, R: T>(ref: Ref<T>, init: () -> R, ?deps: DependencyList): Void;
}

extern interface ReactChildren {
	function map<C, T>(children:OneOf<C, Array<C>>, fn:C->T):Array<T>;
	function foreach<C>(children:OneOf<C, Array<C>>, fn:C->Void):Void;
	function count(children:Dynamic):Int;
	function only<C>(children:C):C;
	function toArray(children:OneOf<ReactNode, Array<ReactNode>>):Array<ReactNode>;
}

@:jsRequire('react', 'Component')
extern class Component<Props> extends StatefulComponent<Props, {}> {}

@:jsRequire('react', 'Component')
extern class StatefulComponent<Props, State> {
	var props(default, null):Props;
	var state(default, null):State;

	function new(?props:Props, ?context:Dynamic);
	function forceUpdate(?callback:Void->Void):Void;
	@:overload(function(nextState:State, ?callback:Void->Void):Void {})
	@:overload(function(nextState:State->Props->State, ?callback:Void->Void):Void {})
	function setState(nextState:State->State, ?callback:Void->Void):Void;
	function render():ReactNode;
	@:native('UNSAFE_componentWillMount')
	function componentWillMount():Void;
	function componentDidMount():Void;
	function componentWillUnmount():Void;
	@:native('UNSAFE_componentWillReceiveProps')
	function componentWillReceiveProps(nextProps:Props):Void;
	function shouldComponentUpdate(nextProps:Props, nextState:State):Bool;
	@:native('UNSAFE_componentWillUpdate')
	function componentWillUpdate(nextProps:Props, nextState:State):Void;
	function componentDidUpdate(prevProps:Props, prevState:State, ?snapshot:Dynamic):Void;
	function componentDidCatch(error:Error, info:{componentStack:String}):Void;
	function getSnapshotBeforeUpdate(prevProps:Props, prevState:State):Dynamic;
}

@:jsRequire('react', 'PureComponent')
extern class PureComponent<Props> extends Component<Props> {}

@:jsRequire('react', 'PureComponent')
extern class PureStatefulComponent<Props, State> extends StatefulComponent<Props, State> {}