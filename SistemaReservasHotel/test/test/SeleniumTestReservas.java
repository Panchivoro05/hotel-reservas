package test;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.Select;

public class SeleniumTestReservas {

    public static void main(String[] args) {

        testAbrirPagina();
        testRegistrarReserva();
        testEliminarReserva();

    }
    // TEST 1: Abrir página principal
    public static void testAbrirPagina() {
        try {
            System.setProperty("webdriver.chrome.driver", "D:\\drivers\\chromedriver-win64\\chromedriver.exe");
            WebDriver driver = new ChromeDriver();

            driver.manage().window().maximize();
            driver.get("http://localhost:8080/SistemaReservasHotel/");

            Thread.sleep(2000);

            System.out.println("Test 1: Página principal cargada correctamente");

            driver.quit();

        } catch (Exception e) {
            System.out.println("Error en Test 1: " + e.getMessage());
        }
    }

    // TEST 2: Registrar nueva reservación
    public static void testRegistrarReserva() {
        try {
            System.setProperty("webdriver.chrome.driver", "D:\\drivers\\chromedriver-win64\\chromedriver.exe");
            WebDriver driver = new ChromeDriver();

            driver.manage().window().maximize();

            driver.get("http://localhost:8080/SistemaReservasHotel/ReservaServlet?action=nuevo");

            Thread.sleep(2000);

            driver.findElement(By.name("codigo")).sendKeys("RSV-SELENIUM-01");


            Select selectCliente = new Select(driver.findElement(By.name("idCliente")));
            selectCliente.selectByIndex(1);  // Seleccionar el primer cliente válido

            Thread.sleep(500);


            Select selectHabitacion = new Select(driver.findElement(By.name("idHabitacion")));
            selectHabitacion.selectByIndex(1);  // Primera habitación disponible

            Thread.sleep(500);

            driver.findElement(By.name("fechaEntrada")).sendKeys("30-11-2025");


            driver.findElement(By.name("diasEstadia")).sendKeys("2");


            Select selectTipo = new Select(driver.findElement(By.name("tipoReservacion")));
            selectTipo.selectByVisibleText("Recepción");

            Thread.sleep(1000);


            driver.findElement(By.cssSelector("button.btn.btn-primary.btn-lg")).click();

            Thread.sleep(3000);

            System.out.println("Test 2: Reservación registrada correctamente");

            driver.quit();

        } catch (Exception e) {
            System.out.println("Error en Test 2: " + e.getMessage());
        }
    }


    // TEST 3: Eliminar última reservación de la tabla
    public static void testEliminarReserva() {
        try {
            System.setProperty("webdriver.chrome.driver", "D:\\drivers\\chromedriver-win64\\chromedriver.exe");
            WebDriver driver = new ChromeDriver();

            driver.manage().window().maximize();

            driver.get("http://localhost:8080/SistemaReservasHotel/ReservaServlet");

            Thread.sleep(2000);

            driver.findElement(By.xpath("(//a[contains(@href, 'action=eliminar')])[last()]")).click();

            Thread.sleep(2000);

            System.out.println("Test 3: Última reservación eliminada correctamente");

            driver.quit();

        } catch (Exception e) {
            System.out.println("Error en Test 3: " + e.getMessage());
        }
    }
}




