package tests;

import react.ReactDOM.Server.renderToString;
import react.React.createElement in h;

final MyView = () -> h('div', {}, 'hello world');

function main()
  trace(renderToString(h(MyView)));