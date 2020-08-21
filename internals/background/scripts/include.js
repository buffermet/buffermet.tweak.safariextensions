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
          browser.webRequest.onAuthRequired.listeners.push()
        }
        for (let i = 0; i < browser.webRequest.onAuthRequired.listeners.length; i++) {
          if (listener.name == browser.webRequest.onAuthRequired.listeners[i][0].name) {
            return;
          }
        }
        browser.webRequest.onAuthRequired.listeners.push([
          listener,
          filter,
          extraInfoSpec]);
      },
      "hasListener": name => {
        for (let i = 0; i < browser.webRequest.onAuthRequired.listeners.length; i++) {
          if (name == browser.webRequest.onAuthRequired.listeners[i][0].name) {
            return true;
          }
        }
        return false;
      },
      "listeners": [],
      "removeListener": name => {
        const listeners = browser.webRequest.onAuthRequired.listeners;
        for (let i = 0; i < listeners.length; i++) {
          if (name === listeners[i][0].name) {
            browser.webRequest.onAuthRequired.listeners = listeners.slice(0,i).concat(listeners.splice(i+1));
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
        for (let i = 0; i < browser.webRequest.onBeforeRequest.listeners.length; i++) {
          if (listener.name == browser.webRequest.onBeforeRequest.listeners[i][0].name) {
            return;
          }
        }
        browser.webRequest.onBeforeRequest.listeners.push([
          listener,
          filter,
          extraInfoSpec]);
      },
      "hasListener": name => {
        for (let i = 0; i < browser.webRequest.onBeforeRequest.listeners.length; i++) {
          if (name == browser.webRequest.onBeforeRequest.listeners[i][0].name) {
            return true;
          }
        }
        return false;
      },
      "listeners": [],
      "removeListener": name => {
        const listeners = browser.webRequest.onBeforeRequest.listeners;
        for (let i = 0; i < listeners.length; i++) {
          if (name === listeners[i][0].name) {
            browser.webRequest.onBeforeRequest.listeners = listeners.slice(0,i).concat(listeners.splice(i+1));
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
        for (let i = 0; i < browser.webRequest.onBeforeSendHeaders.listeners.length; i++) {
          if (listener.name == browser.webRequest.onBeforeSendHeaders.listeners[i][0].name) {
            return;
          }
        }
        browser.webRequest.onBeforeSendHeaders.listeners.push([
          listener,
          filter,
          extraInfoSpec]);
      },
      "hasListener": name => {
        for (let i = 0; i < browser.webRequest.onBeforeSendHeaders.listeners.length; i++) {
          if (name == browser.webRequest.onBeforeSendHeaders.listeners[i][0].name) {
            return true;
          }
        }
        return false;
      },
      "listeners": [],
      "removeListener": name => {
        const listeners = browser.webRequest.onBeforeSendHeaders.listeners;
        for (let i = 0; i < listeners.length; i++) {
          if (name === listeners[i][0].name) {
            browser.webRequest.onBeforeSendHeaders.listeners = listeners.slice(0,i).concat(listeners.splice(i+1));
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
        for (let i = 0; i < browser.webRequest.onHeadersReceived.listeners.length; i++) {
          if (listener.name == browser.webRequest.onHeadersReceived.listeners[i][0].name) {
            return;
          }
        }
        browser.webRequest.onHeadersReceived.listeners.push([
          listener,
          filter,
          extraInfoSpec]);
      },
      "hasListener": name => {
        for (let i = 0; i < browser.webRequest.onHeadersReceived.listeners.length; i++) {
          if (name == browser.webRequest.onHeadersReceived.listeners[i][0].name) {
            return true;
          }
        }
        return false;
      },
      "listeners": [],
      "removeListener": name => {
        const listeners = browser.webRequest.onHeadersReceived.listeners;
        for (let i = 0; i < listeners.length; i++) {
          if (name === listeners[i][0].name) {
            browser.webRequest.onHeadersReceived.listeners = listeners.slice(0,i).concat(listeners.splice(i+1));
            return;
          }
        }
        // throw some error here ...
      }
    }
  }
};

/* automatically generated details object of HTTP request */

var details = {
  /* ... */
};

/* automatically generated series of blocking and non-blocking listeners for above targeted request */

(function(details){
  // callback here
  return details;
})(details);
(async function(details){
  // callback here  
})(details);
(function(details){
  // callback here
  return details;
})(details);

