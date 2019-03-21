import './css/main.css';
import './css/styles.css';
import '../node_modules/tachyons/css/tachyons.min.css';
import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';


Elm.Main.init({
  node: document.getElementById('root'),
});

registerServiceWorker();
