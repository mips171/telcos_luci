/*
	Bars for LuCI
	
	Pass this function a value in seconds and it will make a progress bar for you.

	Copyright 2018 Nicholas Smith <mips171@icloud.com>

	Licensed under the GNU GPLv2.0
	
*/

function createProgressbar(id, duration, callback) {
  /* We select the div that we want to turn into a progressbar */
  var progressbar = document.getElementById(id);
  progressbar.className = 'progressbar';

  /* We create the div that changes width to show progress */
  var progressbarinner = document.createElement('div');
  progressbarinner.className = 'inner';

  /* Now we set the animation parameters */
  progressbarinner.style.animationDuration = duration;

  /* Eventually couple a callback */
  if (typeof(callback) === 'function') {
    progressbarinner.addEventListener('animationend', callback);
  }

  progressbar.appendChild(progressbarinner);

  progressbarinner.style.animationPlayState = 'running';
}
