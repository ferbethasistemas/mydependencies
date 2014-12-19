###
List dependencies of npm projects.
@class Dependency
@author Jan Sanchez
###

###
# Module dependencies.
###

console.log(__dirname)

chalk       = require('chalk')
packageJson = require('./package.json')

console.log(packageJson)

###
# Library.
###

Dependencies = (opts) ->

	@settings = opts or {}
	@ArrayDependencies = []
	@counter = 0
	@output = ""
	@namesOfDependencies = ['devDependencies', 'dependencies', 'peerDependencies', 'bundleDependencies', 'optionalDependencies']

	@getDependencies()
	@readDependencies()
	@writeDependencies()

	return @


Dependencies::getDependencies = () ->
	for dependencyName in @namesOfDependencies
		@pushDependencies(packageJson[dependencyName])
	return


Dependencies::pushDependencies = (dependencyObject) ->
	if dependencyObject is undefined
		return false
	if Object.keys(dependencyObject).length is 0
		return false
	@ArrayDependencies.push(dependencyObject)
	return


Dependencies::readDependencies = () ->
	for dependency, i in @ArrayDependencies
		@output += "\n" + " " + @namesOfDependencies[i] + ": " + "\n\n"
		@readKeys(dependency)
	return


Dependencies::readKeys = (dependency) ->
	for key of dependency
		if (dependency.hasOwnProperty(key))
			@counter++
			@output += "  " + chalk.cyan(" " + key) + "\n"
	return


Dependencies::writeDependencies = () ->
	@output += "\n" + " - - - - - - - - - - - - - - - - - - - -" + "\n"
	@output += chalk.green.bold(' We have found ' + @counter + ' dependencies!') + "\n"
	console.log(@output)
	return



###
# Expose library.
###

module.exports = Dependencies
