package banking;



import java.sql.Timestamp;
import java.util.Date;

public class EducationLoanApplication {

    private int id;
    private String fullName;
    private String contactInfo;
    private String address;
    private Date dob;
    private String aadhaarNumber;
    private String academicRecords;
    private String admissionLetter;
    private String feeStructure;
    private String entranceExamScores;
    private String coBorrowerName;
    private String coBorrowerRelationship;
    private String coBorrowerIncomeProof;
    private double loanAmount;
    private Timestamp applicationDate;

    // Default constructor
    public EducationLoanApplication() {}

    // Getter and Setter methods
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getContactInfo() {
        return contactInfo;
    }

    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getAadhaarNumber() {
        return aadhaarNumber;
    }

    public void setAadhaarNumber(String aadhaarNumber) {
        this.aadhaarNumber = aadhaarNumber;
    }

    public String getAcademicRecords() {
        return academicRecords;
    }

    public void setAcademicRecords(String academicRecords) {
        this.academicRecords = academicRecords;
    }

    public String getAdmissionLetter() {
        return admissionLetter;
    }

    public void setAdmissionLetter(String admissionLetter) {
        this.admissionLetter = admissionLetter;
    }

    public String getFeeStructure() {
        return feeStructure;
    }

    public void setFeeStructure(String feeStructure) {
        this.feeStructure = feeStructure;
    }

    public String getEntranceExamScores() {
        return entranceExamScores;
    }

    public void setEntranceExamScores(String entranceExamScores) {
        this.entranceExamScores = entranceExamScores;
    }

    public String getCoBorrowerName() {
        return coBorrowerName;
    }

    public void setCoBorrowerName(String coBorrowerName) {
        this.coBorrowerName = coBorrowerName;
    }

    public String getCoBorrowerRelationship() {
        return coBorrowerRelationship;
    }

    public void setCoBorrowerRelationship(String coBorrowerRelationship) {
        this.coBorrowerRelationship = coBorrowerRelationship;
    }

    public String getCoBorrowerIncomeProof() {
        return coBorrowerIncomeProof;
    }

    public void setCoBorrowerIncomeProof(String coBorrowerIncomeProof) {
        this.coBorrowerIncomeProof = coBorrowerIncomeProof;
    }

    public double getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(double loanAmount) {
        this.loanAmount = loanAmount;
    }

    public Timestamp getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(Timestamp applicationDate) {
        this.applicationDate = applicationDate;
    }
}
