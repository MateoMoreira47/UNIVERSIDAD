const yesBtn = document.querySelector('#yesBtn');
const audio = document.getElementById("audio");
const playPauseButton = document.getElementById("play-pause");

yesBtn.addEventListener('click',function () {
    alert('Querida "Juana Lisbeth Yareli Del Niño Jesús Rodriguez" así como estas flores amarillas iluminan mi día con su cálido resplandor, tú iluminas mi vida con tu presencia radiante y llena de alegría. Cada día que paso a tu lado es un regalo que atesoro profundamente. Tu sonrisa, tu amabilidad y tu compañía hacen que mi mundo sea más hermoso. \n\nEres la persona que me hace muy feliz')
    alert('Con cariño y admiración: San Juan Emilio Escobar Gavilán')
});

const noBtn = document.querySelector('#noBtn');

noBtn.addEventListener('mouseover', function () {
    const randomX = parseInt(Math.random()*100);
    const randomY = parseInt(Math.random()*100);
    noBtn.style.setProperty('top',randomY+'%');
    noBtn.style.setProperty('left',randomX+'%');
    noBtn.style.setProperty('transform',`translate(-${randomX}%,-${randomY}%)`);
})

playPauseButton.addEventListener("click", function () {
    if (audio.paused || audio.ended) {
        audio.play();
        playPauseButton.textContent = "Pause";
    } else {
        audio.pause();
        playPauseButton.textContent = "Play";
    }
});

audio.addEventListener("ended", function () {
    playPauseButton.textContent = "Play";
});