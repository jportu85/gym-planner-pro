function loadRoutine() {
  const goal = goalSelect.value;
  const level = levelSelect.value;
  const days = daysSelect.value;

  const routine = routines.find(r =>
    r.goal === goal && r.level === level && r.days === days
  );

  const container = document.getElementById("routine");
  container.innerHTML = "";

  if (!routine) {
    container.innerHTML = "<p>No hay rutina para esa selección</p>";
    return;
  }

  localStorage.setItem("currentRoutine", JSON.stringify(routine));

  routine.plan.forEach((d, i) => {
    let html = `<div class="card"><h3>${d.day}</h3>`;
    d.exercises.forEach(ex => {
      html += `<div class="exercise">
        <span>${ex}</span>
        <input type="checkbox" onchange="toggleDone(this)">
      </div>`;
    });
    html += "</div>";
    container.innerHTML += html;
  });

  buildPlanner(routine.plan);
}

function toggleDone(el) {
  el.parentElement.classList.toggle("done");
}

function buildPlanner(plan) {
  const week = document.getElementById("week");
  week.innerHTML = "";
  plan.forEach(d => {
    week.innerHTML += `<div class="card">${d.day}</div>`;
  });
}

function toggleTheme() {
  document.body.classList.toggle("dark");
  document.body.classList.toggle("light");
}

if ("serviceWorker" in navigator) {
  navigator.serviceWorker.register("service-worker.js");
}
