" Description: Search Dash.app from Vim
" Author: José Otávio Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:module = {}

let s:module.groups = {
      \ 'actionscript' : ['actionscript'],
      \ 'c' : ['c', 'glib', 'gl2', 'gl3', 'gl4', 'manpages'],
      \ 'cpp' : ['cpp', 'net', 'boost', 'qt', 'cvcpp', 'cocos2dx', 'c', 'manpages'],
      \ 'cs' : ['net', 'mono', 'unity3d'],
      \ 'cappuccino' : ['cappuccino'],
      \ 'clojure' : ['clojure'],
      \ 'coffee' : ['coffee'],
      \ 'cf' : ['cf'],
      \ 'css' : ['css', 'bootstrap', 'foundation', 'less', 'awesome', 'cordova', 'phonegap'],
      \ 'dart' : ['dartlang', 'polymerdart', 'angulardart'],
      \ 'elixir' : ['elixir'],
      \ 'erlang' : ['erlang'],
      \ 'go' : ['go', 'godoc'],
      \ 'haskell' : ['haskell'],
      \ 'haml' : ['haml'],
      \ 'html' : ['html', 'svg', 'css', 'bootstrap', 'foundation', 'awesome', 'statamic', 'javascript', 'jquery', 'jqueryui', 'jquerym', 'angularjs', 'backbone', 'marionette', 'meteor', 'moo', 'prototype', 'ember', 'lodash', 'underscore', 'sencha', 'extjs', 'knockout', 'zepto', 'cordova', 'phonegap', 'yui'],
      \ 'jade' : ['jade'],
      \ 'java' : ['java', 'javafx', 'grails', 'groovy', 'playjava', 'spring', 'cvj', 'processing', 'javadoc'],
      \ 'javascript' : ['javascript', 'jquery', 'jqueryui', 'jquerym', 'angularjs', 'backbone', 'marionette', 'meteor', 'sproutcore', 'moo', 'prototype', 'bootstrap', 'foundation', 'lodash', 'underscore', 'ember', 'sencha', 'extjs', 'titanium', 'knockout', 'zepto', 'yui', 'd3', 'svg', 'dojo', 'coffee', 'nodejs', 'express', 'grunt', 'mongoose', 'moment', 'require', 'awsjs', 'jasmine', 'sinon', 'chai', 'html', 'css', 'cordova', 'phonegap', 'unity3d'],
      \ 'less' : ['less'],
      \ 'lisp' : ['lisp'],
      \ 'lua' : ['lua', 'corona'],
      \ 'ocaml' : ['ocaml'],
      \ 'perl' : ['perl', 'manpages'],
      \ 'php': ['php', 'wordpress', 'drupal', 'zend', 'laravel', 'yii', 'joomla', 'ee', 'codeigniter', 'cakephp', 'phpunit', 'phpp', 'symfony', 'typo3', 'twig', 'smarty', 'html', 'statamic', 'mysql', 'sqlite', 'mongodb', 'psql', 'redis'],
      \ 'puppet' : ['puppet'],
      \ 'python' : ['python', 'django', 'twisted', 'sphinx', 'flask', 'tornado', 'sqlalchemy', 'numpy', 'scipy', 'salt', 'cvp'],
      \ 'r' : ['r'],
      \ 'ruby' : ['ruby', 'rubygems', 'rails'],
      \ 'rust' : ['rust'],
      \ 'sass' : ['sass', 'compass', 'bourbon', 'neat', 'css'],
      \ 'scala' : ['scala', 'akka', 'playscala', 'scaladoc'],
      \ 'sh' : ['bash', 'manpages'],
      \ 'sql' : ['mysql', 'sqlite', 'psql'],
      \ 'tcl' : ['tcl'],
      \ 'tex' : ['latex'],
      \ 'yaml' : ['chef', 'ansible']
      \ }

let dash#defaults#module = s:module
