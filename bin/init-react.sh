#!/bin/bash
# npm init -y
echo 'init for create-react-app'

mkdir -p src/redux/{actions,reducers,sagas}

echo "
import createSagaMiddleware from 'redux-saga';
import { compose, applyMiddleware, createStore } from 'redux';
import { rootSaga } from './sagas';
import rootReducer from './reducers';

const sagaMiddleware = createSagaMiddleware();
const middlewares = [sagaMiddleware];
// eslint-disable-next-line no-underscore-dangle
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
const defaultStore = {};
const store = createStore(
  rootReducer,
  defaultStore,
  composeEnhancers(applyMiddleware(...middlewares)),
);
sagaMiddleware.run(rootSaga);

export default store;
" | tee "src/redux/store.js" &>/dev/null

echo "
import { combineReducers } from 'redux';
import { combineActions, handleActions } from 'redux-actions';
import { actions } from '../actions';
const { increment, decrement } = actions;

const LOADING_STATE = {
  LOADING: 'loading',
  LOADED: 'loaded',
  FAILED: 'failed',
};

const counterReducer = handleActions(
  {
    [combineActions(increment, decrement)]: (state, { payload: { amount } }) => {
      return { ...state, counter: state.counter + amount };
    },
  },
  { counter: 0 },
);

const rootReducer = combineReducers({
  counter: counterReducer,

  apiResponse: handleActions(
    {
      [actions.apiDone]: (state, action) => {
        return {
          status: LOADING_STATE.LOADED,
          data: action.payload.data,
        };
      },
      [actions.apiRequest]: (state, action) => {
        return {
          status: LOADING_STATE.LOADING,
        };
      },
    },

    { apiData: null },
  ),
});

export default rootReducer;
" | tee "src/redux/reducers/index.js" &>/dev/null

echo "
import { all, select, takeEvery, call, put } from 'redux-saga/effects';
import { actions } from '../actions';
import axios from 'axios';

const fetchData = (axiosConfig) => {
  return axios(axiosConfig);
};

function* handleHttpGet({ payload }) {
  try {
    const { data } = yield call(fetchData, payload);
    yield put(actions.apiDone(data));
  } catch (exception) {
    const error = exception.toString();
    yield put(actions.apiError(error));
  }
}
export function* rootSaga() {
  yield all([
    takeEvery(actions.apiRequest, handleHttpGet),
    takeEvery('*', function* logger(action) {
      const state = yield select();
      console.info('saga', action, state);
    }),
  ]);
}
" | tee "src/redux/sagas/index.js" &>/dev/null

echo "
import { createActions } from 'redux-actions';

export const actions = createActions({
  API_REQUEST: (requestConfig) => requestConfig,
  API_DONE: (data) => ({ data }),
  API_ERROR: (error) => ({ error }),
  INCREMENT: (amount = 1) => ({ amount }),
  DECREMENT: (amount = 1) => ({ amount: -amount }),
});
" | tee "src/redux/actions/index.js" &>/dev/null

npx mrm gitignore
npm i -D prettier eslint-config-prettier
npm i -S redux react-redux redux-saga redux-actions axios lodash

rm -f .eslintrc.json

echo '
module.exports = {
  parser: "babel-eslint",
  parserOptions: {
    sourceType: "module"
  },
  env: {
    commonjs: true,
    jest: true,
    es6: true,
    node: true,
    browser: true,
  },
  extends: ["react-app", "react-app/jest", "prettier"],
  rules: {
    "no-undef": "error",
    "no-unused-vars": "warn",
    "no-console": "off",
  },
};' | tee ".eslintrc.js" &>/dev/null

echo '
module.exports = {
  "$schema": "http://json.schemastore.org/prettierrc",
  arrowParens: "always",
  printWidth: 88,
  useTabs: false,
  singleQuote: true,
  tabWidth: 2,
  trailingComma: "all",
  overrides: [
    {
      files: ["*.yaml", "*.yml"],
      options: {
        singleQuote: false,
      },
    },
  ],
};' | tee "prettier.config.js" &>/dev/null

echo '
[*.{js,jsx}]
charset = utf-8
indent_style = space
indent_size = 2

[git/config]
indent_style = tab

[Makefile]
indent_style = tab

[*.{json,yaml,yml}]
indent_style = space
indent_size = 2
' | tee ".editorconfig" &>/dev/null

cat package.json | jq 'del(.eslintConfig)' | sponge package.json

echo "
Now,

1. src/index.js:
    import { Provider } from 'react-redux');
    import store from './redux/store';
    // wrap <App /> with react-redux's
    <Provider store={store}><App /></Provider>
2. App.js: import one of the actions, and dispatch it with button click
    import { useDispatch } from 'react-redux';
    import { actions } from './redux/actions';
    <button onClick={() => dispatch(actions.apiRequest('https://httpbin.org/get'))}>
      api request
    </button>
"

npx prettier -w src
