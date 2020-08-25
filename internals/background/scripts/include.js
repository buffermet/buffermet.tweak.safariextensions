"use strict";

/* include.js */

const alphanumericChars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
const commentSelector = /((\/\/.*$)|(\/\*[\s\S]*?\*\/))/mg;
const parameterSelector = /([^\s,]+)/g;

const randomString = length => {
  let buffer = new Array(length);
  for (let i = 0; i < length; i++) {
    const charIndex = Math.floor(Math.rand() * alphanumericChars.length);
    buffer[i] = alphanumericChars[charIndex];
  }
  return buffer.join("");
};

function getParameterNames(fn) {
  const fnString = fn.toString().replace(commentSelector, "");
  var result = fnString
    .slice(fnString.indexOf("(") + 1, fnString.indexOf(")"))
    .match(parameterSelector);
  if (result === null) {
    result = [];
  }
  return result;
}

const browser = {
  "webRequest": {
    "onAuthRequired": {
      "addListener": (listener, filter, extraInfoSpec) => {
        if (listener.name == "") {
          listener.name = randomString(128);
        } else {
          this.listeners.push()
        }
        for (let i = 0; i < this.listeners.length; i++) {
          if (listener.name == this.listeners[i][0].name) {
            return;
          }
        }
        this.listeners.push([
          listener,
          filter,
          extraInfoSpec]);
      },
      "hasListener": name => {
        for (let i = 0; i < this.listeners.length; i++) {
          if (name == this.listeners[i][0].name) {
            return true;
          }
        }
        return false;
      },
      "hasListeners": () => {
//        if (!this.eventOptions_.supportsListeners)
//          throw new Error('This event does not support listeners.');
        return this.listeners.length > 0;
      },
      "listeners": [],
      "removeListener": name => {
        const listeners = this.listeners;
        for (let i = 0; i < listeners.length; i++) {
          if (name === listeners[i][0].name) {
            this.listeners.splice(i+1));
            return;
          }
        }
        // throw some error here ...
      }
    },
    "onBeforeRequest": {
      "addListener": (listener, filter, extraInfoSpec) => {
        if (listener.name == "") {
          listener.name = randomString(128);
        }
        for (let i = 0; i < this.listeners.length; i++) {
          if (listener.name == this.listeners[i][0].name) {
            return;
          }
        }
        this.listeners.push([
          listener,
          filter,
          extraInfoSpec]);
      },
      "hasListener": name => {
        for (let i = 0; i < this.listeners.length; i++) {
          if (name == this.listeners[i][0].name) {
            return true;
          }
        }
        return false;
      },
      "hasListeners": () => {
//        if (!this.eventOptions_.supportsListeners)
//          throw new Error('This event does not support listeners.');
        return this.listeners.length > 0;
      },
      "listeners": [],
      "removeListener": name => {
        const listeners = this.listeners;
        for (let i = 0; i < listeners.length; i++) {
          if (name === listeners[i][0].name) {
            this.listeners.splice(i+1));
            return;
          }
        }
        // throw some error here ...
      }
    },
    "onBeforeSendHeaders": {
      "addListener": (listener, filter, extraInfoSpec) => {
        if (listener.name == "") {
          listener.name = randomString(128);
        }
        for (let i = 0; i < this.listeners.length; i++) {
          if (listener.name == this.listeners[i][0].name) {
            return;
          }
        }
        this.listeners.push([
          listener,
          filter,
          extraInfoSpec]);
      },
      "hasListener": name => {
        for (let i = 0; i < this.listeners.length; i++) {
          if (name == this.listeners[i][0].name) {
            return true;
          }
        }
        return false;
      },
      "hasListeners": () => {
//        if (!this.eventOptions_.supportsListeners)
//          throw new Error('This event does not support listeners.');
        return this.listeners.length > 0;
      },
      "listeners": [],
      "removeListener": name => {
        const listeners = this.listeners;
        for (let i = 0; i < listeners.length; i++) {
          if (name === listeners[i][0].name) {
            this.listeners.splice(i+1));
            return;
          }
        }
        // throw some error here ...
      }
    },
    "onHeadersReceived": {
      "addListener": (listener, filter, extraInfoSpec) => {
        if (listener.name == "") {
          listener.name = randomString(128);
        }
        for (let i = 0; i < this.listeners.length; i++) {
          if (listener.name == this.listeners[i][0].name) {
            return;
          }
        }
        this.listeners.push([
          listener,
          filter,
          extraInfoSpec]);
      },
      "hasListener": name => {
        for (let i = 0; i < this.listeners.length; i++) {
          if (name == this.listeners[i][0].name) {
            return true;
          }
        }
        return false;
      },
      "hasListeners": () => {
//        if (!this.eventOptions_.supportsListeners)
//          throw new Error('This event does not support listeners.');
        return this.listeners.length > 0;
      },
      "listeners": [],
      "removeListener": name => {
        const listeners = this.listeners;
        for (let i = 0; i < listeners.length; i++) {
          if (name === listeners[i][0].name) {
            this.listeners.splice(i+1));
            return;
          }
        }
        // throw some error here ...
      }
    }
  }
};

